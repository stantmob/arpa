module Arpa
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
            Arpa::Entities::Role.new(params)
          end

          def validate_role(role)
            validator = Arpa::Validators::RoleValidator.new(role)
            raise Arpa::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def creator_repo
            @creator_repo ||= Arpa::Repositories::Roles::Creator.new
          end

        end
      end
    end
  end
end

