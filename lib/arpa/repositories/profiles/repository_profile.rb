module Arpa
  module Repositories
    module Profiles
      class RepositoryProfile < ActiveRecord::Base
        default_scope {where(removed: false).order(name: :asc)}

        has_and_belongs_to_many :roles, class_name: 'Arpa::Repositories::Roles::RepositoryRole'

      end
    end
  end
end
