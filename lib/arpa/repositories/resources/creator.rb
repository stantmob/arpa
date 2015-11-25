module Arpa
  module Repositories
    module Resources
      class Creator
        include Arpa::Repositories::Registrator

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
