require 'chimpy/version'
require 'chimpy/configuration'
require 'chimpy/sync'
require 'chimpy/base'
require 'chimpy/user_manager'
require 'chimpy/email_service'
require 'chimpy/railtie' if defined?(Rails)

module Chimpy

  def self.run
    Base.run
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
