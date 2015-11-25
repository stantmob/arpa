module Ar
  module DataMappers
    class ResourceMapper < Base
      entity_class 'Ar::Entities::Resource'

      attributes_to_map :id, :name, :full_name,
        actions: {mapper: 'Ar::DataMappers::ActionMapper'}
    end
  end
end
