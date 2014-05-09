require "minitest/spec"
require "minitest/autorun"
require "minitest/pride"
require 'test_helper'
require 'chimpy'


describe Chimpy::Base do
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

