module Arpa
  module Repositories
    module Actions
      class Finder
        include Arpa::Repositories::Base

        def by_name_and_resource(name, resource_id)
          record = repository_class.where(name: name, repository_resource_id: resource_id).first
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
