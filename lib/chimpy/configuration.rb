module Chimpy
  class Configuration
    attr_accessor :model_to_sync

    def initialize
      @model_to_sync = 'User'
    end
  end
end