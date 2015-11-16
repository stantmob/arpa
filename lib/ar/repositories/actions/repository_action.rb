module Ar
  module Repositories
    module Actions
      class RepositoryAction < ActiveRecord::Base
        default_scope {order(name: :asc)}

        alias_attribute :resource_id, :repository_resource_id
        belongs_to :resource, foreign_key: 'repository_resource_id', class_name: 'Ar::Repositories::Resources::RepositoryResource'

      end
    end
  end
end
