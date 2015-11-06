module Ar
  module Validators
    class ActionValidator
      include ActiveModel::Validations

      attr_reader :name

      validates :name, presence: true

      def initialize(action)
        @name = action.name
      end

    end
  end
end
