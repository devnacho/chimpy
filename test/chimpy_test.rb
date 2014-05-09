require "minitest/spec"
require "minitest/autorun"
require "minitest/pride"
require 'test_helper'
require 'chimpy'


describe Chimpy::Base do

  describe "it says hello" do

    it "says hello" do
      Chimpy::Base.hello.must_equal "Hello"
    end
  end
end

