module Arpa
  module Repositories
    module Profiles
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

        def all_by_entity(entity_id, entity_class)
          repository_class
            .where("( (entity_id is null AND entity_class is null) OR (entity_id = '#{entity_id}' AND entity_class = '#{entity_class}') )" )
            .collect do |record|
              mapper_instance.map_to_entity(record)
          end
        end

        def mapper_instance
          Arpa::DataMappers::ProfileMapper.instance
        end

        def repository_class
          RepositoryProfile
        end

      end
    end
  end
end
