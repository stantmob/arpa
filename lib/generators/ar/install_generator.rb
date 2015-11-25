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

        copy_file '../../ar/views/roles/index.html.erb', 'app/views/ar/roles/index.html.erb'
        copy_file '../../ar/views/roles/show.html.erb', 'app/views/ar/roles/show.html.erb'
        copy_file '../../ar/views/roles/new.html.erb', 'app/views/ar/roles/new.html.erb'
        copy_file '../../ar/views/roles/edit.html.erb', 'app/views/ar/roles/edit.html.erb'
        copy_file '../../ar/views/roles/_form.html.erb', 'app/views/ar/roles/_form.html.erb'

        copy_file '../../ar/views/profiles/index.html.erb', 'app/views/ar/profiles/index.html.erb'
        copy_file '../../ar/views/profiles/show.html.erb', 'app/views/ar/profiles/show.html.erb'
        copy_file '../../ar/views/profiles/new.html.erb', 'app/views/ar/profiles/new.html.erb'
        copy_file '../../ar/views/profiles/edit.html.erb', 'app/views/ar/profiles/edit.html.erb'
        copy_file '../../ar/views/profiles/_form.html.erb', 'app/views/ar/profiles/_form.html.erb'
      end

      def copy_stylesheet_files
        copy_file '../../ar/assets/stylesheets/ar_accordion.scss', 'app/assets/stylesheets/ar/ar_accordion.scss'
      end

      def add_controllers
        copy_file '../../ar/controllers/resources_controller.rb', 'app/controllers/ar/resources_controller.rb'
        copy_file '../../ar/controllers/roles_controller.rb', 'app/controllers/ar/roles_controller.rb'
        copy_file '../../ar/controllers/profiles_controller.rb', 'app/controllers/ar/profiles_controller.rb'
      end

      def add_routes
        route <<-RUBY
scope module: :ar do
    resources :resources do
      collection do
        get 'generate_resources_and_actions'
      end
    end

    resources :roles do
      collection do
        delete ':id', to: 'roles#remove'
      end
    end

    resources :profiles do
      collection do
        delete ':id', to: 'profiles#remove'
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
