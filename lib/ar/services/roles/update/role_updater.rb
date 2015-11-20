module Ar
  module Services
    module Roles
      module Update
        class RoleUpdater

          def update(params)
            role = role_instance(params)
            validate_role(role)
            updater_repo.update(role)
          end

          private

          def role_instance(params)
            Ar::Entities::Role.new(params)
          end

          def validate_role(role)
            validator = Ar::Validators::RoleValidator.new(role)
            raise Ar::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def updater_repo
            @updater_repo ||= Ar::Repositories::Roles::Updater.new
          end

        end
      end
    end
  end
end
