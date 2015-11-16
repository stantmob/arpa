module Ar
  module DataMappers
    class RoleMapper < Base
      attributes_to_map :id, :name, :description, :action_ids, :actions, :removed, :created_at, :updated_at
    end
  end
end
