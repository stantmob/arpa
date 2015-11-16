module Ar
  module Repositories
    module Roles
      class RepositoryRole < ActiveRecord::Base
        default_scope {where(removed: false).order(name: :asc)}

      end
    end
  end
end
