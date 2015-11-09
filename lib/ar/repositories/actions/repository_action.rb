module Ar
  module Repositories
    module Resources
      class ActionRepository < ActiveRecord::Base

        belongs_to :resource, class_name: 'Ar::Repositories::Resources::RepositoryResource'

      end
    end
  end
end
