module Arpa
  module Services
    module Profiles
      class ProfileManagerCreator
        include Arpa::Services::Base

        def create(params, callback)
          manager_action callback do
            profile_creator.create(params[:profile])
          end
        end

        private

        def profile_creator
          @profile_creator ||= Arpa::Services::Profiles::Create::ProfileCreator.new
        end

      end
    end
  end
end
