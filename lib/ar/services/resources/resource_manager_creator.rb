module Ar
  module Services
    module Resources
      class ResourceManagerCreator
        include Ar::Services::Base

        def create(params, callback)
          manager_action callback do
            resourceables = params[:resourceables]

            resource_remover.remove_nonexistent_resources(resourceables)

            resourceables.collect do |resourceable|
              resource = resource_creator.create(resourceable)
              action_params = action_params(resource, resourceable)
              action_creator.create_many(action_params)

              resource
            end
          end
        end

        private

        def resource_remover
          @resource_remover ||= Ar::Services::Resources::Remove::ResourceRemover.new
        end

        def resource_creator
          @resource_creator ||= Ar::Services::Resources::Create::ResourceCreator.new
        end

        def action_creator
          @action_creator ||= Ar::Services::Actions::Create::ActionCreator.new
        end

        def action_params(resource, resourceable)
          {resource: resource, actions_names: resourceable.actions_methods}
        end

      end
    end
  end
end
