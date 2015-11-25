module Arpa
  module Repositories
    module Profiles
      class Creator
        include Arpa::Repositories::Registrator

        def mapper_instance
          Arpa::DataMappers::ProfileMapper.instance
        end

        def repository_class
          RepositoryProfile
        end

      end
    end
  end
end
