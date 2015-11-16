module Ar
  module Repositories
    module Actions
      class Remover
        include Ar::Repositories::Base

        def destroy(entity)
          # repository_class.destroy(entity.id)
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
