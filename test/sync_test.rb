require 'test_helper'

describe Chimpy::Sync do
  describe "#chimpy_sync" do
    it "should have method chimpy_sync" do
      temp = Class.new(ActiveRecord::Base)
      temp.send(:define_singleton_method, :columns, Proc.new { [] })
      temp.include(Chimpy::Sync)
      u = temp.new
      assert_respond_to(u, :chimpy_sync)
    end
    it "should call chimpy_sync" do
      temp = Class.new(ActiveRecord::Base)
      temp.send(:define_singleton_method, :columns, Proc.new { [] })
      temp.send(:define_method, :create_or_update, Proc.new { true })
      temp.send(:define_method, :email, Proc.new { "test@test.com" })
      temp.send(:define_method, :chimpy_synced_at=, Proc.new {|t| t })
      temp.include(Chimpy::Sync)
      VCR.use_cassette('sync', :record => :once) do
        u = temp.new
        u.save
        assert_send([u, :chimpy_sync])
      end
    end
  end
end
