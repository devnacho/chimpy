require 'test_helper'

describe Chimpy::Configuration do
  describe "#sync_class" do
    it "default value is User" do
      Chimpy::Configuration.new.sync_class.must_equal :user
    end
  end
  describe "#sync_class=" do
    it "can set value" do
      config = Chimpy::Configuration.new
      config.sync_class = :admin
      config.sync_class.must_equal :admin
    end
  end
end
