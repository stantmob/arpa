module Ar
  module DataMappers
    class ActionMapper < Base
      entity_class 'Ar::Entities::Action'

      attrs_to_entity :id, :resource_id, :name, :created_at, :updated_at,
        resource: {mapper: 'Ar::DataMappers::ResourceMapper'}
      attrs_to_record :id, :resource_id, :name, :created_at, :updated_at

    end
  end
end
