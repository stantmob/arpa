module Ar
  module Repositories
    module Resources
      class RepositoryResource < ActiveRecord::Base

        has_many :actions, dependent: :destroy, class_name: 'Ar::Repositories::Actions::RepositoryAction'

      end
    end
  end
end
