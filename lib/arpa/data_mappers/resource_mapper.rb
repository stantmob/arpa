module Arpa
  module DataMappers
    class ResourceMapper < Base
      entity_class 'Arpa::Entities::Resource'
      repository_class 'Arpa::Repositories::Resources::RepositoryResource'

      attributes_to_map :id, :name, :full_name,
        actions: {mapper: 'Arpa::DataMappers::ActionMapper'}
    end
  end
end
