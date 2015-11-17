module Ar
  module Services
    module Roles
      module Update
        class RoleUpdater

          def update(params)
            role = resource_instance(params)
            validate_resource(role)
            updater_repo.update(role)
          end

          private

          def resource_instance(params)
            Ar::Entities::Role.new(params)
          end

          def validate_resource(role)
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
