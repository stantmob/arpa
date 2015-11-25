module Ar
  module DataMappers
    class ActionMapper < Base
      entity_class 'Ar::Entities::Action'
      repository_class 'Ar::Repositories::Actions::RepositoryAction'

      attrs_to_entity :id, :resource_id, :name, :created_at, :updated_at,
        resource: {mapper: 'Ar::DataMappers::ResourceMapper'}
      attrs_to_record :id, :resource_id, :name, :created_at, :updated_at

    end
  end
end
