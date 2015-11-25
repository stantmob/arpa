module Arpa
  module Entities
    class Profile

      attr_reader :id, :name, :description, :role_ids, :roles, :created_at, :updated_at, :removed

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @id          = attrs[:id]
        @name        = attrs[:name]
        @description = attrs[:name]
        @role_ids    = attrs[:role_ids] || []
        @roles       = attrs[:roles] || []
        @created_at  = attrs[:created_at]
        @updated_at  = attrs[:updated_at]
        @removed     = attrs[:removed] || false
      end

    end
  end
end
