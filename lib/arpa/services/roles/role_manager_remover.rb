module Arpa
  module Services
    module Roles
      class RoleManagerRemover
        include Arpa::Services::Base

        def remove(params, callback)
          manager_action callback do
            role = params[:role]
            role_remover.remove(role)
          end
        end

        private

        def role_remover
          @role_remover ||= Arpa::Services::Roles::Remove::RoleRemover.new
        end

      end
    end
  end
end
