module Arpa
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
            Arpa::Entities::Role.new(params)
          end

          def validate_role(role)
            validator = Arpa::Validators::RoleValidator.new(role)
            raise Arpa::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def updater_repo
            @updater_repo ||= Arpa::Repositories::Roles::Updater.new
          end

        end
      end
    end
  end
end
