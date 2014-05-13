# Chimpy

Chimpy syncs your users from your DB to your respective lists in MailChimp.

## Installation

Add this line to your application's Gemfile:

    gem 'chimpy'

Then execute:

    $ bundle

Set in your config/environment.rb (or in each environment file) the details for the class you would like to sync with MailChimp. It defaults to User

``` ruby
Chimpy.configure do |config|
  config.sync_class = User
end

```
Run Chimpy Generator

$ rails g chimpy:migrate

After that execute the generated migration

$ rake db:migrate

Add these environment variables to your application

    MAILCHIMP_API_KEY=
    MAILCHIMP_LIST_ID=

## Usage

To sync your users just run the following rake task. It is recommended to run it frequently with a cron or schedule it with Heroku Scheduler.

$ rake chimpy:sync

## Contributing

1. Fork it ( http://github.com/<my-github-username>/chimpy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
