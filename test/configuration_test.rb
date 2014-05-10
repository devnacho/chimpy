require 'test_helper'

describe Chimpy::Configuration do
  describe "#sync_class" do
    it "default value is User" do
      Chimpy::Configuration.new.sync_class.must_equal User
    end
  end
  describe "#sync_class=" do
    it "can set value" do
      config = Chimpy::Configuration.new
      config.sync_class = Object.const_set("Admin" ,Class.new)
      config.sync_class.must_equal Admin
    end
  end
end