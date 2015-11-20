module Ar
  module Services
    module Profiles
      module Update
        class ProfileUpdater

          def update(params)
            profile = profile_instance(params)
            validate_profile(profile)
            updater_repo.update(profile)
          end

          private

          def profile_instance(params)
            Ar::Entities::Profile.new(params)
          end

          def validate_profile(profile)
            validator = Ar::Validators::ProfileValidator.new(profile)
            raise Ar::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def updater_repo
            @updater_repo ||= Ar::Repositories::Profiles::Updater.new
          end

        end
      end
    end
  end
end
