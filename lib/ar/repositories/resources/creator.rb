module Ar
  module Repositories
    module Resources
      class Creator
        include Ar::Repositories::Registrator

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
