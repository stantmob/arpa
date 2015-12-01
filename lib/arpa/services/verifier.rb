module Arpa
  module Services
    class Verifier

      def initialize(session, current_user)
        @session      = session
        @current_user = current_user
      end

      def has_access?(resource, action)
        free_access_action = action.to_s.split('_')[0]
        return true if @current_user.is_arpa_admin? || free_access_action.empty?
        @session[:entity_permissions] ||= action_finder.permissions(@current_user.profile_ids)
        @session[:entity_permissions].has_permission?(resource.to_s, action.to_s)
      end

      def reset_permissions
        @session[:entity_permissions] = nil
      end

      private

      def action_finder
        @action_finder ||= Arpa::Repositories::Actions::Finder.new
      end
    end
  end
end
