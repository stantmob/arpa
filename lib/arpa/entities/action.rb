module Arpa
  module Entities
    class Action

      attr_reader :id, :resource_id, :resource, :name, :created_at, :updated_at

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @id          = attrs[:id]
        @resource_id = attrs[:resource_id]
        @resource    = attrs[:resource]
        @name        = attrs[:name]
        @created_at  = attrs[:created_at]
        @updated_at  = attrs[:updated_at]
      end

      def resource_name
        return resource.name if resource
        ''
      end

      def description
        I18n.t(name.to_sym, scope: "entities.resources.#{resource_name}.actions.description")
      end

    end
  end
end
