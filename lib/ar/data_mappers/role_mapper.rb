module Ar
  module DataMappers
    class RoleMapper < Base
      attributes_to_map :id, :name, :description, :removed, :created_at, :updated_at
    end
  end
end
