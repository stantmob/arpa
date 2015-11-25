module Ar
  module DataMappers
    class RoleMapper < Base
      entity_class 'Ar::Entities::Role'
      repository_class 'Ar::Repositories::Roles::RepositoryRole'

      attrs_to_entity :id, :name, :description, :action_ids, :removed, :created_at, :updated_at,
        {actions: {mapper: 'Ar::DataMappers::ActionMapper'} },
        {profiles: {mapper: 'Ar::DataMappers::ProfileMapper'}}

      attrs_to_record :id, :name, :description, :action_ids, :removed, :created_at, :updated_at
    end
  end
end
