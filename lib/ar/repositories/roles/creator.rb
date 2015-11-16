module Ar
  module Repositories
    module Roles
      class Creator
        include Ar::Repositories::Registrator

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
