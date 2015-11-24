module Ar
  module DataMappers
    class ActionMapper < Base

      attrs_to_entity :id, :resource_id, :name, :created_at, :updated_at,
        resource: {entity: 'Ar::Entities::Resource', mapper: 'Ar::DataMappers::ResourceMapper'}
      attrs_to_record :id, :resource_id, :name, :created_at, :updated_at

    end
  end
end
