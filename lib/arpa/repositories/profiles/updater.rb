module Arpa
  module Repositories
    module Profiles
      class Updater
        include Arpa::Repositories::Registrator

        def post_update(entity, record)
          record.role_ids = entity.role_ids
          record.save!
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
