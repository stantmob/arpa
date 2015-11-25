module Arpa
  module Validators
    class RoleValidator
      include ActiveModel::Validations

      attr_reader :name, :description, :action_ids

      validates :name, :description, presence: true
      validates :action_ids, presence: { message: :many_blank }


      def initialize(role)
        @name        = role.name
        @description = role.description
        @action_ids  = role.action_ids
      end

    end
  end
end
