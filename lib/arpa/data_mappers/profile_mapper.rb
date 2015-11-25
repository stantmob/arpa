module Arpa
  module DataMappers
    class ProfileMapper < Base
      entity_class 'Arpa::Entities::Profile'
      repository_class 'Arpa::Repositories::Profiles::RepositoryProfile'

      attrs_to_entity :id, :name, :description, :role_ids, :removed, :created_at, :updated_at,
        roles: {mapper: 'Arpa::DataMappers::RoleMapper'}

      attrs_to_record :id, :name, :description, :role_ids, :removed, :created_at, :updated_at

    end
  end
end
