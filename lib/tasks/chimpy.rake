namespace :chimpy do
  desc 'Runs Chimpy. It syncs your users to your desired MailChimp list'
  task :sync do
    Chimpy::Base.new.run
  end
end