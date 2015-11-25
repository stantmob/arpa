module Ar
  module Repositories
    module Roles
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
          Ar::DataMappers::RoleMapper.instance
        end

        def repository_class
          RepositoryRole
        end

      end
    end
  end
end
