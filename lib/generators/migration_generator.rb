require 'rails/generators'
require 'rails/generators/migration'


module Chimpy
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    def copy_files
      @sync_class = Chimpy.configuration.sync_class.to_s
      migration_template('add_column_to_sync_class.rb.erb', "db/migrate/add_chimpy_to_#{@sync_class.underscore.pluralize}.rb")
    end

    def self.next_migration_number(dirname) #:nodoc:
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  end
end