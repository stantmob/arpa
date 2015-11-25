module Arpa
  module Services
    module Resources
      module Remove
        class ResourceRemover

          def remove_nonexistent_resources(resourceables)
            resourceables_names = resourceables.map { |r| r.to_s }

            finder_repo.all.each do |resource|
              exist = resourceables_names.include?(resource.full_name)
              remover_repo.destroy(resource) unless exist
            end

          end

          private

          def finder_repo
            @finder_repo ||= Arpa::Repositories::Resources::Finder.new
          end

          def remover_repo
            @remover_repo ||= Arpa::Repositories::Resources::Remover.new
          end

        end
      end
    end
  end
end
