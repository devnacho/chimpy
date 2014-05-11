module Chimpy
  class UserManager
    attr_reader :sync_class, :configuration

    def self.to_sync
      sync_class = Chimpy.configuration.sync_class

      never_synced = sync_class.where(chimpy_synced_at: nil)
      needing_sync = sync_class.where('updated_at > chimpy_synced_at')
      never_synced + needing_sync
    end

    def self.mark_as_synced(users)
      users.each { |user| user.update(chimpy_synced_at: Time.now) }
    end
  end
end