module Ar
  module Services
    module Profiles
      module Create
        class ProfileCreator

          def create(params)
            profile = resource_instance(params)
            validate_resource(profile)
            creator_repo.create(profile)
          end

          private

          def resource_instance(params)
            Ar::Entities::Profile.new(params)
          end

          def validate_resource(profile)
            validator = Ar::Validators::ProfileValidator.new(profile)
            raise Ar::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def creator_repo
            @creator_repo ||= Ar::Repositories::Profiles::Creator.new
          end

        end
      end
    end
  end
end
