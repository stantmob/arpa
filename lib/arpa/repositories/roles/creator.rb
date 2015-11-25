module Arpa
  module Repositories
    module Roles
      class Creator
        include Arpa::Repositories::Registrator

        def mapper_instance
          Arpa::DataMappers::RoleMapper.instance
        end

        def repository_class
          RepositoryRole
        end

      end
    end
  end
end
