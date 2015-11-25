module Ar
  module Repositories
    module Profiles
      class Remover
        include Ar::Repositories::Base

        def destroy(entity)
          repository_class.destroy(entity.id)
        end

        def disable(entity)
          record = mapper_instance.map_to_record(repository_class, entity)
          repository_class.update(record.id, removed: true)
          record.reload
          mapper_instance.map_to_entity(record)
        end

        def mapper_instance
          Ar::DataMappers::ProfileMapper.instance
        end

        def repository_class
          RepositoryProfile
        end

      end
    end
  end
end
