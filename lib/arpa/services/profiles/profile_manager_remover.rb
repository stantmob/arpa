module Arpa
  module Services
    module Profiles
      class ProfileManagerRemover
        include Arpa::Services::Base

        def remove(params, callback)
          manager_action callback do
            role    = params[:profile]
            disable = params[:disable]
            profile_remover.remove(role, disable)
          end
        end

        private

        def profile_remover
          @profile_remover ||= Arpa::Services::Profiles::Remove::ProfileRemover.new
        end

      end
    end
  end
end
