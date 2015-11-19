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

        def by_full_name(full_name)
          record = repository_class.where(full_name: full_name).first
          mapper_instance.map_to_entity(record, Ar::Entities::Resource.new) if record
        end

        def permissions(profile_ids)
         records = repository_class.joins(actions: [roles: :profiles])
           .where(repository_profiles: {id: profile_ids})

          resources = records.collect do |record|
            mapper_instance.map_to_entity(record, Ar::Entities::Resource.new)
          end

          Ar::Entities::Permissions.new(resources)
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
