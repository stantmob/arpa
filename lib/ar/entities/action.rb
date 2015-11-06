module Ar
  module Entities
    class Action

      attr_reader :id, :resource, :name, :created_at, :updated_at

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @id         = attrs[:id]
        @resource   = attrs[:resource]
        @name       = attrs[:name]
        @created_at = attrs[:created_at]
        @updated_at = attrs[:updated_at]
      end

      def description
        I18n.t(name.to_sym, scope: "entities.resources.#{resource.name}.actions.description")
      end

    end
  end
end
