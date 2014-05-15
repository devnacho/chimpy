namespace :chimpy do
  desc 'Runs Chimpy. It syncs your users to your desired MailChimp list'
  task :sync => :environment do
    Chimpy::Base.run
  end
end