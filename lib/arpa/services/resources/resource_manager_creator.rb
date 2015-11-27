module Arpa
  module Services
    module Resources
      class ResourceManagerCreator
        include Arpa::Services::Base

        def create(params, callback)
          manager_action callback do
            resourceables         = params[:resourceables]
            except_action_methods = params[:except_action_methods] || []

            resource_remover.remove_nonexistent_resources(resourceables)

            resourceables.collect do |resourceable|
              resource = resource_creator.create(resourceable)
              action_params = action_params(resource, resourceable, except_action_methods)

              action_remover.remove_nonexistent_actions(action_params)
              action_creator.create_many(action_params)

              resource
            end
          end
        end

        private

        def resource_remover
          @resource_remover ||= Arpa::Services::Resources::Remove::ResourceRemover.new
        end

        def action_remover
          @action_remover ||= Arpa::Services::Actions::Remove::ActionRemover.new
        end

        def resource_creator
          @resource_creator ||= Arpa::Services::Resources::Create::ResourceCreator.new
        end

        def action_creator
          @action_creator ||= Arpa::Services::Actions::Create::ActionCreator.new
        end

        def action_params(resource, resourceable, except_action_methods)
          actions_names = resourceable.action_methods.select{ |action| !except_action_methods.include?(action) }
          { resource: resource, actions_names: actions_names }
        end

      end
    end
  end
end
