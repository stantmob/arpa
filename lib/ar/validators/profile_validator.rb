module Ar
  module Validators
    class ProfileValidator
      include ActiveModel::Validations

      attr_reader :name, :description

      validates :name, :description, presence: true

      def initialize(profile)
        @name        = profile.name
        @description = profile.description
      end

    end
  end
end
