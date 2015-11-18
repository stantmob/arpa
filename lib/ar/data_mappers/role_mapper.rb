module Ar
  module DataMappers
    class RoleMapper < Base
      attrs_to_entity :id, :name, :description, :action_ids, :actions, :profiles, :removed, :created_at, :updated_at
      attrs_to_record :id, :name, :description, :action_ids, :removed, :created_at, :updated_at
    end
  end
end
