module Ar
  module Entities
    class Role

      attr_reader :name, :description, :created_at, :updated_at, :removed

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @name        = attrs[:name]
        @description = attrs[:name]
        @created_at  = attrs[:created_at]
        @updated_at  = attrs[:updated_at]
        @removed     = attrs[:removed]
      end

    end
  end
end
