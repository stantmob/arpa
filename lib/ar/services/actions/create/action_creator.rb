module Ar
  module Services
    module Actions
      module Create
        class ActionCreator

          def create_many(params)
            params[:actions_names].each do |action_name|
              create(action_params(params, action_name))
            end
          end

          def create(params)
            action = action_instance(params)
            validate_action(action)
            creator_repo.create(action)
          end

          private

          def action_params(params, action_name)
            parameters = Hash.new
            parameters[:name] = action_name
            parameters.merge(params.slice(:resource))
          end

          def action_instance(params)
            Ar::Entities::Action.new(params)
          end

          def validate_action(action)
            validator = Ar::Validators::ActionValidator.new(action)
            raise Ar::Exceptions::RecordInvalid.new(message: validator.errors.messages, errors: validator.errors) unless validator.valid?
          end

          def creator_repo
            @creator_repo ||= Ar::Repositories::Actions::Creator.new
          end

        end
      end
    end
  end
end
