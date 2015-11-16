module Ar
  module Entities
    class Role

      attr_reader :id, :name, :description, :action_ids, :actions, :created_at, :updated_at, :removed

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @id          = attrs[:id]
        @name        = attrs[:name]
        @description = attrs[:description]
        @action_ids  = attrs[:action_ids] || []
        @actions     = attrs[:actions] || []
        @created_at  = attrs[:created_at]
        @updated_at  = attrs[:updated_at]
        @removed     = attrs[:removed]
      end

    end
  end
end
