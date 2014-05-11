module Chimpy
  class Base

    def run
      synced_users = EmailService.new.sync(UserManager.to_sync)
      UserManager.mark_as_synced(synced_users)
    end

  end
end