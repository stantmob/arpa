module Arpa
  module Services
    module Actions
      module Create
        class ActionCreator

          def create_many(params)
            params[:actions_names].collect do |action_name|
              create(action_params(params, action_name))
            end
          end

          def create(params)
            action = action_instance(params)

            action_found = finder_repo.by_name_and_resource(params[:name], params[:resource_id])
            return action_found if action_found

            validate_action(action)
            creator_repo.create(action)
          end

          private

          def action_params(params, action_name)
            {name: action_name, resource_id: params[:resource].id}
          end

          def action_instance(params)
            Arpa::Entities::Action.new(params)
          end

          def validate_action(action)
            validator = Arpa::Validators::ActionValidator.new(action)
            raise Arpa::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def finder_repo
            @finder_repo ||= Arpa::Repositories::Actions::Finder.new
          end

          def creator_repo
            @creator_repo ||= Arpa::Repositories::Actions::Creator.new
          end

        end
      end
    end
  end
end
