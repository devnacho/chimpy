require 'test_helper'

describe Chimpy::Base do

  before do
    Chimpy.configure do |config|
      config.sync_class = :user
    end
  end

  describe "run" do
    before do
      @new_user = User.create(email: "david.gilmour@gmail.com", skip_mailchimp_sync: true)
      @already_synced = User.create(email: "roger.waters@gmail.com", chimpy_synced_at: 1.day.ago, updated_at: 3.days.ago, skip_mailchimp_sync: true)
      @to_sync = User.create(email: "nick.mason@gmail.com", chimpy_synced_at: 5.days.ago, updated_at: 1.day.ago, skip_mailchimp_sync: true)
      VCR.use_cassette('run', :record => :once) do
        Chimpy.run
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
end
