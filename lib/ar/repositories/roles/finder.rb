module Ar
  module Repositories
    module Roles
      class Finder
        include Ar::Repositories::Base

        def all
          repository_class.all.collect do |record|
            mapper_instance.map_to_entity(record, Ar::Entities::Role.new)
          end
        end

        def mapper_instance
          Ar::DataMappers::RoleMapper.instance
        end

        def repository_class
          RepositoryRole
        end

      end
    end
  end
end
