module Ar
  module Repositories
    module Resources
      class Finder
        include Ar::Repositories::Base

        def all
          repository_class.all.collect do |record|
            mapper_instance.map_to_entity(record, Ar::Entities::Resource.new)
          end
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
