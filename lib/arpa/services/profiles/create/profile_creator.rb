module Arpa
  module Services
    module Profiles
      module Create
        class ProfileCreator

          def create(params)
            profile = profile_instance(params)
            validate_profile(profile)
            creator_repo.create(profile)
          end

          private

          def profile_instance(params)
            Arpa::Entities::Profile.new(params)
          end

          def validate_profile(profile)
            validator = Arpa::Validators::ProfileValidator.new(profile)
            raise Arpa::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def creator_repo
            @creator_repo ||= Arpa::Repositories::Profiles::Creator.new
          end

        end
      end
    end
  end
end
