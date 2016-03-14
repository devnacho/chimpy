module Chimpy
  module Sync
    def self.included(base)
      base.before_save do
        es = Chimpy::EmailService.new
        es.sync(Array.wrap(self))
        self.chimpy_synced_at = Time.now
      end
    end
  end
end
