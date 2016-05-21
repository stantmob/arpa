module Arpa
  module Entities
    class Role

      attr_reader :id, :name, :description, :created_at, :updated_at, :removed,
        :action_ids, :actions, :profiles

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @id          = attrs[:id]
        @name        = attrs[:name]
        @description = attrs[:description]
        @action_ids  = default_value_to_nil_or_empty(attrs[:action_ids], [])
        @actions     = default_value_to_nil_or_empty(attrs[:actions], [])
        @profiles    = default_value_to_nil_or_empty(attrs[:profiles], [])
        @created_at  = attrs[:created_at]
        @updated_at  = attrs[:updated_at]
        @removed     = default_value_to_nil_or_empty(attrs[:removed], false)
      end

      def has_profile?
        profiles.present?
      end

      private
      def default_value_to_nil_or_empty(attr_value, default_value)
        return attr_value if attr_value.present?
        default_value
      end

    end
  end
end
