module Chimpy
  class Configuration
    attr_accessor :sync_class, :mailchimp_api_key, :mailchimp_list_id

    def initialize
      @sync_class = User
      @mailchimp_api_key = ENV['MAILCHIMP_API_KEY']
      @mailchimp_list_id = ENV['MAILCHIMP_LIST_ID']
    end
  end
end
