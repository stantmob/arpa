module Arpa
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("..", __FILE__)

      def self.next_migration_number(dirname)
        return Time.new.utc.strftime("%Y%m%d%H%M%S") if ActiveRecord::Base.timestamped_migrations
        "%.3d" % (current_migration_number(dirname) + 1)
      end

      def create_migrate_files
        migration_template 'templates/migration.rb', 'db/migrate/create_arpa_tables.rb'
      end

      def copy_resources_views_files
        copy_file '../../arpa/views/resources/index.html.erb', 'app/views/arpa/resources/index.html.erb'
        copy_file '../../arpa/views/resources/show.html.erb', 'app/views/arpa/resources/show.html.erb'

        copy_file '../../arpa/views/roles/index.html.erb', 'app/views/arpa/roles/index.html.erb'
        copy_file '../../arpa/views/roles/show.html.erb', 'app/views/arpa/roles/show.html.erb'
        copy_file '../../arpa/views/roles/new.html.erb', 'app/views/arpa/roles/new.html.erb'
        copy_file '../../arpa/views/roles/edit.html.erb', 'app/views/arpa/roles/edit.html.erb'
        copy_file '../../arpa/views/roles/_form.html.erb', 'app/views/arpa/roles/_form.html.erb'

        copy_file '../../arpa/views/profiles/index.html.erb', 'app/views/arpa/profiles/index.html.erb'
        copy_file '../../arpa/views/profiles/show.html.erb', 'app/views/arpa/profiles/show.html.erb'
        copy_file '../../arpa/views/profiles/new.html.erb', 'app/views/arpa/profiles/new.html.erb'
        copy_file '../../arpa/views/profiles/edit.html.erb', 'app/views/arpa/profiles/edit.html.erb'
        copy_file '../../arpa/views/profiles/_form.html.erb', 'app/views/arpa/profiles/_form.html.erb'
      end

      def copy_stylesheet_files
        copy_file '../../arpa/assets/stylesheets/arpa_accordion.scss', 'app/assets/stylesheets/arpa/arpa_accordion.scss'
      end

      def add_controllers
        copy_file '../../arpa/controllers/resources_controller.rb', 'app/controllers/arpa/resources_controller.rb'
        copy_file '../../arpa/controllers/roles_controller.rb', 'app/controllers/arpa/roles_controller.rb'
        copy_file '../../arpa/controllers/profiles_controller.rb', 'app/controllers/arpa/profiles_controller.rb'
      end

      def add_routes
        route <<-RUBY
scope module: :arpa do
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
        copy_file '../../config/locales/arpa.en.yml', 'config/locales/arpa.en.yml'
      end

    end
  end
end
