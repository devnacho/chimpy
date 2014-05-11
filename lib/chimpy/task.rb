require 'chimpy'
require 'rails'
module Chimpy
  class Task < Rails::Railtie
    railtie_name :chimpy

    rake_tasks do
      load "tasks/chimpy.rake"
    end
  end
end