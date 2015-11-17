module Ar
  module DataMappers
    class ActionMapper < Base

      attrs_to_entity :id, :resource_id, :resource, :name, :created_at, :updated_at
      attrs_to_record :id, :resource_id, :name, :created_at, :updated_at

    end
  end
end
