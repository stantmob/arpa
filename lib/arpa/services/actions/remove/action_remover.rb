module Arpa
  module Services
    module Actions
      module Remove
        class ActionRemover

          def remove_nonexistent_actions(params)
            params[:resource].actions.each do |action|
              exist = params[:actions_names].include?(action.name)
              remover_repo.destroy(action) unless exist
            end
          end

          private

          def remover_repo
            @remover_repo ||= Arpa::Repositories::Actions::Remover.new
          end

        end
      end
    end
  end
end
