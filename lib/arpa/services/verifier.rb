module Arpa
  module Services
    class Verifier

      def initialize(current_user)
        @current_user = current_user
      end

      def has_access?(resource, action)
        free_access_action = action.to_s.split('_')[0]
        return true if @current_user.is_arpa_admin? || free_access_action.empty?
        action_finder.permission(resource.to_s, action.to_s, @current_user.profile_ids)
      end

      private

      def action_finder
        @action_finder ||= Arpa::Repositories::Actions::Finder.new
      end
    end
  end
end
