module Chimpy
  class Base
    attr_reader :mailchimp, :sync_model, :configuration

    def initialize
      @mailchimp = create_mailchimp_client
      @sync_model = Chimpy.configuration.model_to_sync
    end

    def users_to_sync
      never_synced = Object.const_get(@sync_model).where(chimpy_synced_at: nil)
      needing_sync = Object.const_get(@sync_model).where('updated_at > chimpy_synced_at')
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
        user = Object.const_get(@sync_model).find_by_email(add["email"])
        user.update(chimpy_synced_at: Time.now)
        synced_users << user
      end

      response["updates"].each do |update|
        user = Object.const_get(@sync_model).find_by_email(add["email"])
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