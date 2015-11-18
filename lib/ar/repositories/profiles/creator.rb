module Ar
  module Repositories
    module Profiles
      class Creator
        include Ar::Repositories::Registrator

        def mapper_instance
          Ar::DataMappers::ProfileMapper.instance
        end

        def repository_class
          RepositoryProfile
        end

      end
    end
  end
end
