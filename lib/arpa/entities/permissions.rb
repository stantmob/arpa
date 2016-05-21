module Arpa
  module Entities
    class Permissions

      attr_reader :permissions

      def initialize(actions)
        @actions     = actions
        @permissions = Array.new
        build_permissions
      end

      def has_permission?(resource_name, action_name)
        hash_permission = build_hash_permission(resource_name, action_name)
        permissions.include?(hash_permission)
      end

      private
      def build_permissions
        @actions.collect do |action|
          hash_permission = build_hash_permission(action.resource_name, action.name)
          @permissions << hash_permission unless permissions.include?(hash_permission)
        end
      end

      def build_hash_permission(resource_name, action_name)
        {'resource' => resource_name, 'action' => action_name }
      end

    end
  end
end

