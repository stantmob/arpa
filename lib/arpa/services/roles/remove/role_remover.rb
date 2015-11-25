module Arpa
  module Services
    module Roles
      module Remove
        class RoleRemover

          def remove(entity)
            if entity.has_profile?
              remover_repo.disable(entity)
            else
              remover_repo.destroy(entity)
            end
          end

          private

          def remover_repo
            @remover_repo ||= Arpa::Repositories::Roles::Remover.new
          end

        end
      end
    end
  end
end
