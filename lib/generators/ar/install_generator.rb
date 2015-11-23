module Ar
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("..", __FILE__)

      def self.next_migration_number(dirname)
        return Time.new.utc.strftime("%Y%m%d%H%M%S") if ActiveRecord::Base.timestamped_migrations
        "%.3d" % (current_migration_number(dirname) + 1)
      end

      def create_migrate_files
        migration_template 'templates/migration.rb', 'db/migrate/create_ar_tables.rb'
      end

      def copy_resources_views_files
        copy_file '../../ar/views/resources/index.html.erb', 'app/views/ar/resources/index.html.erb'
        copy_file '../../ar/views/resources/show.html.erb', 'app/views/ar/resources/show.html.erb'
      end

      def copy_stylesheet_files
      end

      def add_controllers
        copy_file '../../ar/controllers/resources_controller.rb', 'app/controllers/ar/resources_controller.rb'
      end

      def add_routes
        route <<-RUBY
        scope module: :ar do
          resources :resources do
            collection do
            get 'generate_resources_and_actions'
            end
          end
        end
        RUBY
      end

      def copy_locales
        copy_file '../../config/locales/ar.en.yml', 'config/locales/ar.en.yml'
      end

    end
  end
end
