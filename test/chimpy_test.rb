require "minitest/spec"
require "minitest/autorun"
require "minitest/pride"
require 'test_helper'
require 'dotenv'
require 'vcr'
require 'database_cleaner'
require 'chimpy'
Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

describe Chimpy::Base do
  describe "users" do
    before do
      @never_synced = User.create(email: "test1@test.com")
      @to_sync = User.create(email: "test2@test.com", chimpy_synced_at: 5.days.ago, updated_at: 1.day.ago)
      @synced = User.create(email: "test3@test.com", chimpy_synced_at: 1.day.ago, updated_at: 3.day.ago)
    end

    it "gets users who have not been synced yet" do
      users_to_sync = Chimpy::Base.users_to_sync
      users_to_sync.include?(@never_synced).must_equal true
    end

    it "gets users who need to be synced" do
      users_to_sync = Chimpy::Base.users_to_sync
      users_to_sync.include?(@to_sync).must_equal true
    end

    it "doesn't bring the users who have been synced already" do
      users_to_sync = Chimpy::Base.users_to_sync
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

