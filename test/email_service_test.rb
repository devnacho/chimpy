require 'test_helper'

describe Chimpy::Base do

  before do
    Chimpy.configure do |config|
      config.sync_class = User
    end
  end

  describe "Email Service" do
    before do
      @user1 = User.create(email: "johnjohnson@gmail.com")
      @user2 = User.create(email: "donjohnson@gmail.com")
      @users = [@user1, @user2]
    end

    it "syncs users to a list" do
      VCR.use_cassette('succesful_list_subscription') do
        synced_users = Chimpy::EmailService.new.sync(@users)
        synced_users.must_equal @users
      end
    end
  end
end

