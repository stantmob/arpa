module Arpa
  module Repositories
    module Actions
      class Remover
        include Arpa::Repositories::Base

        def destroy(entity)
          repository_class.destroy(entity.id)
        end

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
