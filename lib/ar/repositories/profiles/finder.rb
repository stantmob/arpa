module Ar
  module Repositories
    module Profiles
      class Finder
        include Ar::Repositories::Base

        def find(id)
          record = repository_class.find(id)
          mapper_instance.map_to_entity(record, Ar::Entities::Profile.new)
        end

        def all
          repository_class.all.collect do |record|
            mapper_instance.map_to_entity(record, Ar::Entities::Profile.new)
          end
        end

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
