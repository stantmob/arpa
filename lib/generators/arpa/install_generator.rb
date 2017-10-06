module Arpa
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("..", __FILE__)

      desc <<-DESC.strip_heredoc
       The Name of table to create the associate table.

       E.g. users, admins.

       By default is 'users'
       DESC

      argument :associate_table, required: false

      desc <<-DESC.strip_heredoc
        The Primary key to create the associate table.

        E.g. user_id, admin_id.

        By default is 'user_id'
      DESC
      argument :associate_primary_key, required: false

      def self.next_migration_number(dirname)
        return Time.new.utc.strftime("%Y%m%d%H%M%S") if ActiveRecord::Base.timestamped_migrations
        "%.3d" % (current_migration_number(dirname) + 1)
      end

      desc "Create a migrate file with all necessery tables including the associate table."

      def create_migrate_files
        @associate_table       ||= 'users'
        @associate_primary_key ||= "#{@associate_table.singularize}_id"
        migration_template 'templates/migration.rb', 'db/migrate/create_arpa_tables.rb'
      end

      def copy_locales
        copy_file '../../config/locales/arpa.en.yml', 'config/locales/arpa.en.yml'
      end

    end
  end
end
