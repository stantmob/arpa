module Ar
  module Services
    module Roles
      module Create
        class RoleCreator

          def create(params)
            role = role_instance(params)
            validate_role(role)
            creator_repo.create(role)
          end

          private

          def role_instance(params)
            Ar::Entities::Role.new(params)
          end

          def validate_role(role)
            validator = Ar::Validators::RoleValidator.new(role)
            raise Ar::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def creator_repo
            @creator_repo ||= Ar::Repositories::Roles::Creator.new
          end

        end
      end
    end
  end
end

