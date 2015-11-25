module Arpa
  module Validators
    class ActionValidator
      include ActiveModel::Validations

      attr_reader :name, :resource_id

      validates :name, :resource_id, presence: true

      def initialize(action)
        @name        = action.name
        @resource_id = action.resource_id
      end

    end
  end
end
