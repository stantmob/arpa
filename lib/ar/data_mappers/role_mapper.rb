module Ar
  module DataMappers
    class RoleMapper < Base
      attrs_to_entity :id, :name, :description, :action_ids, :removed, :created_at, :updated_at,
        {actions: {entity: 'Ar::Entities::Action', mapper: 'Ar::DataMappers::ActionMapper'} },
        {profiles: {entity: 'Ar::Entities::Profile', mapper: 'Ar::DataMappers::ProfileMapper'}}

      attrs_to_record :id, :name, :description, :action_ids, :removed, :created_at, :updated_at
    end
  end
end
