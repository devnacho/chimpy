require "chimpy/version"
require "chimpy/configuration"
require "chimpy/base"
require 'gibbon'

module Chimpy

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
