module Ar
  module Repositories
    module Actions
      class Creator
        include Ar::Repositories::Registrator

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
