require 'chimpy'
require 'rails'
module Chimpy
  class Railtie < Rails::Railtie
    railtie_name :chimpy

    rake_tasks do
      load "tasks/chimpy.rake"
    end

    generators do
      load "generators/migration_generator.rb"
    end

  end
end