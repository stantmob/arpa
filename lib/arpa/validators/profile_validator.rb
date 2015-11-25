module Arpa
  module Validators
    class ProfileValidator
      include ActiveModel::Validations

      attr_reader :name, :description, :role_ids

      validates :name, :description, presence: true
      validates :role_ids, presence: { message: :many_blank }

      def initialize(profile)
        @name        = profile.name
        @description = profile.description
        @role_ids    = profile.role_ids
      end

    end
  end
end
