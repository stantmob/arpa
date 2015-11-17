module Ar
  module Repositories
    module Roles
      class Updater
        include Ar::Repositories::Registrator

        def post_update(entity, record)
          record.action_ids = entity.action_ids
          record.save!
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
