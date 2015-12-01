module Arpa
  module Generators
    class ControllersGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_resources_views_files
        copy_file 'views/resources/index.html.erb', 'app/views/arpa/resources/index.html.erb'
        copy_file 'views/resources/show.html.erb', 'app/views/arpa/resources/show.html.erb'

        copy_file 'views/roles/index.html.erb', 'app/views/arpa/roles/index.html.erb'
        copy_file 'views/roles/show.html.erb', 'app/views/arpa/roles/show.html.erb'
        copy_file 'views/roles/new.html.erb', 'app/views/arpa/roles/new.html.erb'
        copy_file 'views/roles/edit.html.erb', 'app/views/arpa/roles/edit.html.erb'
        copy_file 'views/roles/_form.html.erb', 'app/views/arpa/roles/_form.html.erb'

        copy_file 'views/profiles/index.html.erb', 'app/views/arpa/profiles/index.html.erb'
        copy_file 'views/profiles/show.html.erb', 'app/views/arpa/profiles/show.html.erb'
        copy_file 'views/profiles/new.html.erb', 'app/views/arpa/profiles/new.html.erb'
        copy_file 'views/profiles/edit.html.erb', 'app/views/arpa/profiles/edit.html.erb'
        copy_file 'views/profiles/_form.html.erb', 'app/views/arpa/profiles/_form.html.erb'
      end

      def copy_stylesheet_files
        copy_file 'assets/stylesheets/arpa_accordion.scss', 'app/assets/stylesheets/arpa/arpa_accordion.scss'
      end

      def add_controllers
        copy_file 'controllers/resources_controller.rb', 'app/controllers/arpa/resources_controller.rb'
        copy_file 'controllers/roles_controller.rb', 'app/controllers/arpa/roles_controller.rb'
        copy_file 'controllers/profiles_controller.rb', 'app/controllers/arpa/profiles_controller.rb'
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

    end
  end
end
