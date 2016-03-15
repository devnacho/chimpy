require 'test_helper'

describe Chimpy::Base do

  before do
    Chimpy.configure do |config|
      config.sync_class = User
    end
  end

  describe "Email Service" do
    before do
      @user1 = User.create(email: "johndonson@gmail.com", skip_mailchimp_sync: true)
      @user2 = User.create(email: "donjohnson@gmail.com", skip_mailchimp_sync: true)
      @users = [@user1, @user2]
    end

    it "syncs users to a list" do
      VCR.use_cassette('succesful_list_subscription', :record => :once) do
        synced_users = Chimpy::EmailService.new.sync(@users)
        synced_users.must_equal @users.map { |user| user.email }
      end
    end
  end
end
