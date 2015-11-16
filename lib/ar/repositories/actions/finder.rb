module Ar
  module Repositories
    module Actions
      class Finder
        include Ar::Repositories::Base

        def by_name_and_resource(name, resource)
        end

        def mapper_instance
          Ar::DataMappers::ActionMapper.instance
        end

        def repository_class
          RepositoryAction
        end

      end
    end
  end
end
