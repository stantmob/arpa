module Ar
  module DataMappers
    class ResourceMapper < Base
      entity_class 'Ar::Entities::Resource'
      repository_class 'Ar::Repositories::Resources::RepositoryResource'

      attributes_to_map :id, :name, :full_name,
        actions: {mapper: 'Ar::DataMappers::ActionMapper'}
    end
  end
end
