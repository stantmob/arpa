module Arpa
  module DataMappers
    class ProfileMapper < Base
      entity_class 'Arpa::Entities::Profile'
      repository_class 'Arpa::Repositories::Profiles::RepositoryProfile'

      attrs_to_entity :id, :name, :description, :role_ids, :entity_id, :entity_class,
        :created_at, :updated_at, :removed,
        roles: {mapper: 'Arpa::DataMappers::RoleMapper'}

      attrs_to_record :id, :name, :description, :role_ids, :entity_id, :entity_class,
        :created_at, :updated_at, :removed

    end
  end
end
