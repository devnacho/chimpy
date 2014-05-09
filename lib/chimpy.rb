require "chimpy/version"

module Chimpy
  class Base
    def self.users_to_sync
      never_synced = User.where(chimpy_synced_at: nil)
      needing_sync = User.where('updated_at > chimpy_synced_at')
      never_synced + needing_sync
    end
  end
end
