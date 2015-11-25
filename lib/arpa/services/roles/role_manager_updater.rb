module Arpa
  module Services
    module Roles
      class RoleManagerUpdater
        include Arpa::Services::Base

        def update(params, callback)
          manager_action callback do
            role_updater.update(params[:role])
          end
        end

        private

        def role_updater
          @role_updater ||= Arpa::Services::Roles::Update::RoleUpdater.new
        end

      end
    end
  end
end
