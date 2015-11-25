module Ar
  module DataMappers
    class ProfileMapper < Base
      attrs_to_entity :id, :name, :description, :role_ids, :removed, :created_at, :updated_at,
        roles: {entity: 'Ar::Entities::Role', mapper: 'Ar::DataMappers::RoleMapper'}

      attrs_to_record :id, :name, :description, :role_ids, :removed, :created_at, :updated_at

    end
  end
end
