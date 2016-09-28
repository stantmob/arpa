module Arpa
  module Repositories
    module Actions
      class Finder
        include Arpa::Repositories::Base

        def by_name_and_resource(name, resource_id)
          record = repository_class.find_by(name: name, repository_resource_id: resource_id)
          mapper_instance.map_to_entity(record) if record
        end

        def permission(resource_name, action_name, profile_ids)
          record = repository_class
            .distinct(true)
            .joins(:resource, roles: :profiles)
            .find_by(repository_profiles: {id: profile_ids},
                     repository_resources: {name: resource_name},
                     name: action_name)
          mapper_instance.map_to_entity(record) if record
        end

        def mapper_instance
          Arpa::DataMappers::ActionMapper.instance
        end

        def repository_class
          RepositoryAction
        end

      end
    end
  end
end
