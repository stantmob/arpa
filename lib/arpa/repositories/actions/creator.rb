module Arpa
  module Repositories
    module Actions
      class Creator
        include Arpa::Repositories::Registrator

        def mapper_instance
          Arpa::DataMappers::ActionMapper.instance
        end

        def repository_class
          RepositoryAction
        end

      end
    end
  end
end
