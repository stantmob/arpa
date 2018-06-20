module Arpa
  module Repositories
    module Resources
      class Finder
        include Arpa::Repositories::Base

        def find(id)
          record = repository_class.find(id)
          mapper_instance.map_to_entity(record)
        end

        def all
          repository_class.all.collect do |record|
            mapper_instance.map_to_entity(record)
          end
        end

        def by_full_name(full_name)
          record = repository_class.where(full_name: full_name).first
          mapper_instance.map_to_entity(record) if record
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
