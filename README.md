# Chimpy

Chimpy syncs your users from your DB to your respective lists in MailChimp.

## Installation

Add this line to your application's Gemfile:

    gem 'chimpy'

Then execute:

    $ bundle

Create an initializer with the details for the class you would like to sync with MailChimp and your mailchimp keys. It defaults to User

``` ruby
#initializers/chimpy.rb

Chimpy.configure do |config|
  config.sync_class = User
  config.mailchimp_api_key = "549391d6ed3fc64fd42e4b5cf83ceba9-us8"
  config.mailchimp_list_id = "788e29440b"
end

```
Run Chimpy Generator

    $ rails g chimpy:migrate

After that execute the generated migration

    $ rake db:migration

## Usage

To sync your users just run the following rake task. It is recommended to run it frequently with a cron or schedule it with Heroku Scheduler.

    $ rake chimpy:sync

## Contributing

1. Fork it ( http://github.com/<my-github-username>/chimpy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
