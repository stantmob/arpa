module Ar
  module Services
    module Resources
      class ResourceManagerCreator
        include Ar::Services::Base

        def create(params, callback)
          manager_action callback do
            params[:resourceables].collect do |resourceable|
              resource = resource_creator.create(resourceable)
              action_params = action_params(resource, resourceable)
              action_creator.create_many(action_params)

              resource
            end
          end
        end

        private

        def resource_creator
        end

        def action_creator
        end

        def action_params(resource, resourceable)
          {resource: resource, actions_names: resourceable.actions_methods}
        end

      end
    end
  end
end
