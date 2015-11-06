module Ar
  module Validators
    class RoleValidator
      include ActiveModel::Validations

      attr_reader :name, :description

      validates :name, :description, presence: true

      def initialize(role)
        @name        = role.name
        @description = role.description
      end

    end
  end
end
