module Ar
  module DataMappers
    class ProfileMapper < Base
      attrs_to_entity :id, :name, :description, :role_ids, :roles, :removed, :created_at, :updated_at
      attrs_to_record :id, :name, :description, :role_ids, :removed, :created_at, :updated_at
    end
  end
end
