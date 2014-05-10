require 'test_helper'

describe Chimpy::Base do

  before do
    Chimpy.configure do |config|
      config.sync_class = User
    end
  end

  describe "run" do
    before do
      @new_user = User.create(email: "david.gilmour@gmail.com")
      @already_synced = User.create(email: "roger.waters@gmail.com", chimpy_synced_at: 1.day.ago, updated_at: 3.days.ago)
      @to_sync = User.create(email: "nick.mason@gmail.com", chimpy_synced_at: 5.days.ago, updated_at: 1.day.ago)
      VCR.use_cassette('run') do
        Chimpy::Base.new.run
      end
    end

    it "syncs the new user" do
      @new_user.reload.chimpy_synced_at.wont_equal nil
    end

    it "syncs the user who needs sync" do
      @to_sync.chimpy_synced_at.must_be :<, @to_sync.reload.chimpy_synced_at
    end

    it "leaves the already synced user untouched" do
      @already_synced.chimpy_synced_at.must_equal  @already_synced.reload.chimpy_synced_at
    end
  end

  describe "users" do
    before do
      @never_synced = User.create(email: "test1@test.com")
      @to_sync = User.create(email: "test2@test.com", chimpy_synced_at: 5.days.ago, updated_at: 1.day.ago)
      @synced = User.create(email: "test3@test.com", chimpy_synced_at: 1.day.ago, updated_at: 3.day.ago)
    end

    it "gets users who have not been synced yet" do
      users_to_sync = Chimpy::Base.new.users_to_sync
      users_to_sync.include?(@never_synced).must_equal true
    end

    it "gets users who need to be synced" do
      users_to_sync = Chimpy::Base.new.users_to_sync
      users_to_sync.include?(@to_sync).must_equal true
    end

    it "doesn't bring the users who have been synced already" do
      users_to_sync = Chimpy::Base.new.users_to_sync
      users_to_sync.include?(@synced).must_equal false
    end
  end

  describe "mailchimp" do
    before do
      @user1 = User.create(email: "johnjohnson@gmail.com")
      @user2 = User.create(email: "donjohnson@gmail.com")
      @users = [@user1, @user2]
    end
    it "syncs users to a list" do
      VCR.use_cassette('succesful_list_subscription') do
        Chimpy::Base.new.sync(@users)
        @users.each do |user|
          user.reload.chimpy_synced_at.wont_equal nil
        end
      end
    end
  end
end

