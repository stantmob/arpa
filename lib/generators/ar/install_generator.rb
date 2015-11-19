module Ar
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def self.next_migration_number(dirname)
        return Time.new.utc.strftime("%Y%m%d%H%M%S") if ActiveRecord::Base.timestamped_migrations
        "%.3d" % (current_migration_number(dirname) + 1)
      end

      def create_migration_file
        migration_template 'migration.rb', 'db/migrate/create_ar_tables.rb'
      end

    end
  end
end
