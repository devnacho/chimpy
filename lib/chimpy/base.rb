module Chimpy
  class Base
    def run
      user_manager = UserManager.new
      synced_users = EmailService.new.sync(user_manager.to_sync)
      user_manager.mark_as_synced(synced_users)
    end
  end
end
