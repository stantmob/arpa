module Ar
  module Services
    module Actions
      module Remove
        class ActionRemover

          def remove_nonexistent_actions(params)
            # resourceables_names = resourceables.map { |r| r.to_s }

            # finder_repo.all.each do |resource|
              # exist = resourceables_names.include?(resource.full_name)
              # remover_repo.destroy(resource) unless exist
            # end

          end

          private

          def finder_repo
            @finder_repo ||= Ar::Repositories::Resources::Finder.new
          end

          def remover_repo
            @remover_repo ||= Ar::Repositories::Resources::Remover.new
          end

        end
      end
    end
  end
end
