module Ar
  module Repositories
    module Resources
      class RepositoryResource < ActiveRecord::Base
        default_scope {order(name: :asc)}

        has_many :actions, dependent: :destroy, class_name: 'Ar::Repositories::Actions::RepositoryAction'

      end
    end
  end
end
