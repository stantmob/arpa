module Ar
  module Repositories
    module Resources
      class Finder
        include Ar::Repositories::Base

        def find(id)
          record = repository_class.find(id)
          map_actions_association(record)
          mapper_instance.map_to_entity(record, Ar::Entities::Resource.new)
        end

        def all
          repository_class.all.collect do |record|
            map_actions_association(record)
            mapper_instance.map_to_entity(record, Ar::Entities::Resource.new)
          end
        end

        def by_full_name(full_name)
          record = repository_class.where(full_name: full_name).first
          if record
            map_actions_association(record)
            mapper_instance.map_to_entity(record, Ar::Entities::Resource.new)
          end
        end

        def permissions(profile_ids)
         records = repository_class.joins(actions: [roles: :profiles])
           .where(repository_profiles: {id: profile_ids})

          resources = records.collect do |record|
            map_actions_association(record)
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

        private

        def map_actions_association(record)
          mapper = Ar::DataMappers::ActionMapper.instance
          record.actions.each do |action|
            mapper.map_to_entity(action, Ar::Entities::Action.new)
          end
        end

      end
    end
  end
end
