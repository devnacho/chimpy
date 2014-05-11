require 'gibbon'

module Chimpy
  class EmailService
    attr_reader :mailchimp, :sync_class, :configuration

    def initialize
      @mailchimp = create_mailchimp_client
      @sync_class = Chimpy.configuration.sync_class
    end

    def sync(users)
      struct = users.map { |user| { email: { email: user.email } } }
      response = mailchimp.lists.batch_subscribe(id: ENV['MAILCHIMP_LIST_ID'],
                                                 batch: struct,
                                                 update_existing: true,
                                                 double_optin: false)
      synced_users(response)
    end

    private

    def synced_users(response)
      emails = []
      response['adds'].each do |add|
        emails << add['email']
      end

      response['updates'].each do |update|
        emails << update['email']
      end
      emails
    end

    def create_mailchimp_client
      Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    end
  end
end
