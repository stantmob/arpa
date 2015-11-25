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
        @action_ids  = attrs[:action_ids] || []
        @actions     = attrs[:actions] || []
        @profiles    = attrs[:profiles] || []
        @created_at  = attrs[:created_at]
        @updated_at  = attrs[:updated_at]
        @removed     = attrs[:removed] || false
      end

      def has_profile?
        profiles.present?
      end

    end
  end
end
