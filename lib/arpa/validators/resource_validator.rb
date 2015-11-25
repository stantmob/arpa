module Arpa
  module Validators
    class ResourceValidator
      include ActiveModel::Validations

      attr_reader :full_name, :name

      validates :full_name, :name, presence: true

      def initialize(resource)
        @full_name = resource.full_name
        @name      = resource.name
      end

    end
  end
end
