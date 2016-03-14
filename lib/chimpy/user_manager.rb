module Chimpy
  class UserManager

    def initialize

    end

    def sync_class
      Chimpy.configuration.sync_class.to_s.classify.constantize
    end

    def to_sync
      never_synced = sync_class.where(chimpy_synced_at: nil)
      needing_sync = sync_class.where('updated_at > chimpy_synced_at')
      never_synced + needing_sync
    end

    def mark_as_synced(emails)
      emails.each do |email|
        found = sync_class.find_by_email(email)
        found.update(chimpy_synced_at: Time.now) if found
      end
    end
  end
end
