module Chimpy
  class Configuration
    attr_accessor :sync_class

    def initialize
      @sync_class = User
    end
  end
end
