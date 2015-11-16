module Ar
  module Services
    module Roles
      class RoleManagerCreator
        include Ar::Services::Base

        def create(params, callback)
          manager_action callback do
            role_creator.create(params[:role])
          end
        end

        private

        def role_creator
          @role_creator ||= Ar::Services::Roles::Create::RoleCreator.new
        end

      end
    end
  end
end

