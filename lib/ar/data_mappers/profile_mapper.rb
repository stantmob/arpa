module Ar
  module DataMappers
    class ProfileMapper < Base
      entity_class 'Ar::Entities::Profile'
      repository_class 'Ar::Repositories::Profiles::RepositoryProfile'

      attrs_to_entity :id, :name, :description, :role_ids, :removed, :created_at, :updated_at,
        roles: {mapper: 'Ar::DataMappers::RoleMapper'}

      attrs_to_record :id, :name, :description, :role_ids, :removed, :created_at, :updated_at

    end
  end
end
