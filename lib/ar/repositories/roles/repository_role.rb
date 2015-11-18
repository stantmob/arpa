module Ar
  module Repositories
    module Roles
      class RepositoryRole < ActiveRecord::Base
        default_scope {where(removed: false).order(name: :asc)}

        has_and_belongs_to_many :actions, class_name: 'Ar::Repositories::Actions::RepositoryAction'
        has_and_belongs_to_many :profiles, class_name: 'Ar::Repositories::Profiles::RepositoryProfile'

      end
    end
  end
end
