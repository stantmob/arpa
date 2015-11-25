module Arpa
  module DataMappers
    class ActionMapper < Base
      entity_class 'Arpa::Entities::Action'
      repository_class 'Arpa::Repositories::Actions::RepositoryAction'

      attrs_to_entity :id, :resource_id, :name, :created_at, :updated_at,
        resource: {mapper: 'Arpa::DataMappers::ResourceMapper'}
      attrs_to_record :id, :resource_id, :name, :created_at, :updated_at

    end
  end
end
