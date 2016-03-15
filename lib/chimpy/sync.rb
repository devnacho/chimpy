module Chimpy
  module Sync
    attr_accessor :skip_mailchimp_sync

    def self.included(base)
      base.before_save :chimpy_sync
      def chimpy_sync
        if !self.skip_mailchimp_sync
          es = Chimpy::EmailService.new
          es.sync(Array.wrap(self))
          self.chimpy_synced_at = Time.now
        end
      end
    end
  end
end
