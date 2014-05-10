require 'test_helper'

describe Chimpy::Configuration do
  describe "#model_to_sync" do
    it "default value is User" do
      Chimpy::Configuration.new.model_to_sync.must_equal "User"
    end
  end
  describe "#model_to_sync=" do
    it "can set value" do
      config = Chimpy::Configuration.new
      config.model_to_sync = 'Admin'
      config.model_to_sync.must_equal "Admin"
    end
  end
end