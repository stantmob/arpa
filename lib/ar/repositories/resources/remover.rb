module Ar
  module Repositories
    module Resources
      class Remover
        include Ar::Repositories::Base

        def destroy(entity)
          repository_class.destroy(entity.id)
        end

        def mapper_instance
          Ar::DataMappers::ResourceMapper.instance
        end

        def repository_class
          RepositoryResource
        end

      end
    end
  end
end
