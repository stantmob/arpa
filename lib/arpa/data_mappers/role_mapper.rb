module Arpa
  module DataMappers
    class RoleMapper < Base
      entity_class 'Arpa::Entities::Role'
      repository_class 'Arpa::Repositories::Roles::RepositoryRole'

      attrs_to_entity :id, :name, :description, :action_ids, :removed, :created_at, :updated_at,
        {actions: {mapper: 'Arpa::DataMappers::ActionMapper'} },
        {profiles: {mapper: 'Arpa::DataMappers::ProfileMapper'}}

      attrs_to_record :id, :name, :description, :action_ids, :removed, :created_at, :updated_at
    end
  end
end
