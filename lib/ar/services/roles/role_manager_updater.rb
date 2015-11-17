module Ar
  module Services
    module Roles
      class RoleManagerUpdater
        include Ar::Services::Base

        def update(params, callback)
          manager_action callback do
            role_updater.update(params[:role])
          end
        end

        private

        def role_updater
          @role_updater ||= Ar::Services::Roles::Update::RoleUpdater.new
        end

      end
    end
  end
end
