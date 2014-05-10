module Chimpy
  class Base
    attr_reader :mailchimp, :sync_class, :configuration

    def initialize
      @mailchimp = create_mailchimp_client
      @sync_class = Chimpy.configuration.sync_class
    end

    def run
      sync(users_to_sync)
    end

    def users_to_sync
      never_synced = @sync_class.where(chimpy_synced_at: nil)
      needing_sync = @sync_class.where('updated_at > chimpy_synced_at')
      never_synced + needing_sync
    end

    def sync(users)
      struct = users.map{|user| {email: {email: user.email}}}
      response = @mailchimp.lists.batch_subscribe(id: ENV['MAILCHIMP_LIST_ID'],
                                        batch: struct, update_existing: true, double_optin: false)
      mark_synced_users(response)
    end

    private

    def mark_synced_users(response)
      synced_users = []
      response["adds"].each do |add|
        user = @sync_class.find_by_email(add["email"])
        user.update(chimpy_synced_at: Time.now)
        synced_users << user
      end

      response["updates"].each do |update|
        user = @sync_class.find_by_email(update["email"])
        user.update(chimpy_synced_at: Time.now)
        synced_users << user
      end
      synced_users
    end

    def create_mailchimp_client
      Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    end
  end
end