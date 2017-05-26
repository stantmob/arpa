module Arpa
  module Entities
    class Profile

      attr_reader :id, :name, :description, :role_ids, :roles, :entity_id, :entity_class,
        :created_at, :updated_at, :removed

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @id           = attrs[:id]
        @name         = attrs[:name]
        @description  = attrs[:description]
        @role_ids     = default_value_to_nil_or_empty(attrs[:role_ids], [])
        @roles        = default_value_to_nil_or_empty(attrs[:roles], [])
        @entity_id    = attrs[:entity_id]
        @entity_class = attrs[:entity_class]
        @created_at   = attrs[:created_at]
        @updated_at   = attrs[:updated_at]
        @removed      = default_value_to_nil_or_empty(attrs[:removed], false)
      end

      private
      def default_value_to_nil_or_empty(attr_value, default_value)
        return attr_value if attr_value.present?
        default_value
      end

    end
  end
end
