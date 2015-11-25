module Arpa
  module Services
    module Profiles
      module Remove
        class ProfileRemover

          def remove(entity, disable = false)
            if disable
              remover_repo.disable(entity)
            else
              remover_repo.destroy(entity)
            end
          end

          private

          def remover_repo
            @remover_repo ||= Arpa::Repositories::Profiles::Remover.new
          end

        end
      end
    end
  end
end
