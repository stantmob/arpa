module Ar
  module DataMappers
    class ResourceMapper < Base
      attributes_to_map :id, :name, :full_name,
        actions: {entity: 'Ar::Entities::Action', mapper: 'Ar::DataMappers::ActionMapper'}
    end
  end
end
