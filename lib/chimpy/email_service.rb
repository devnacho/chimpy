require 'gibbon'

module Chimpy
  class EmailService
    attr_reader :mailchimp, :mailchimp_api_key, :mailchimp_list_id

    def initialize
      @mailchimp_api_key = Chimpy.configuration.mailchimp_api_key
      @mailchimp_list_id = Chimpy.configuration.mailchimp_list_id
      @mailchimp = create_mailchimp_client
    end

    def sync(users)
      struct = users.map { |user| { email: { email: user.email } } }
      response = mailchimp.lists.batch_subscribe(id: mailchimp_list_id,
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
      Gibbon::API.new(mailchimp_api_key)
    end
  end
end
