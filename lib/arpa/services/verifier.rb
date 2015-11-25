module Arpa
  module Services
    class Verifier

      def initialize(session, current_user)
        @session      = session
        @current_user = current_user
      end

      def has_access?(resource, action)
        free_access_action = action.to_s.split('_')[0]
        return true if free_access_action.empty?
        @session[:entity_permissions] ||= resource_finder.permissions(@current_user.profile_ids)
        @session[:entity_permissions].has_permission?(resource.to_s, action.to_s)
      end

      private

      def resource_finder
        @resource_finder ||= Arpa::Repositories::Resources::Finder.new
      end
    end
  end
end
