module Arpa
  module Services
    module Profiles
      class ProfileManagerUpdater
        include Arpa::Services::Base

        def update(params, callback)
          manager_action callback do
            profile_updater.update(params[:profile])
          end
        end

        private

        def profile_updater
          @profile_updater ||= Arpa::Services::Profiles::Update::ProfileUpdater.new
        end

      end
    end
  end
end
