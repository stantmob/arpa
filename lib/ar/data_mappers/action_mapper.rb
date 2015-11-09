module Ar
  module DataMappers
    class ActionMapper < Base
      attributes_to_map :id, :resource_id, :resource, :name, :created_at, :updated_at
    end
  end
end
