module Arpa
  module Services
    module Resources
      module Create
        class ResourceCreator

          def create(resourceable)
            resource = resource_instance(resourceable)

            resource_found = finder_repo.by_full_name(resource.full_name)
            return resource_found if resource_found

            validate_resource(resource)
            creator_repo.create(resource)
          end

          private

          def resource_instance(resourceable)
            resource = Arpa::Entities::Resource.new(full_name: resourceable.to_s)
            resource.build_correct_name
            resource
          end

          def validate_resource(resource)
            validator = Arpa::Validators::ResourceValidator.new(resource)
            raise Arpa::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def finder_repo
            @finder_repo ||= Arpa::Repositories::Resources::Finder.new
          end

          def creator_repo
            @creator_repo ||= Arpa::Repositories::Resources::Creator.new
          end

        end
      end
    end
  end
end
