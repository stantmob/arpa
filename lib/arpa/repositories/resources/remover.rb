module Arpa
  module Repositories
    module Resources
      class Remover
        include Arpa::Repositories::Base

        def destroy(entity)
          repository_class.destroy(entity.id)
        end

        def mapper_instance
          Arpa::DataMappers::ResourceMapper.instance
        end

        def repository_class
          RepositoryResource
        end

      end
    end
  end
end
