require 'chimpy/version'
require 'chimpy/configuration'
require 'chimpy/base'
require 'chimpy/user_manager'
require 'chimpy/email_service'

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
