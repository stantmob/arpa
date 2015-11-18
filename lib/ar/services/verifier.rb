module Ar
  module Services
    class Verifier

      def initialize(session, current_user)
        @session      = session
        @current_user = current_user
      end

      def has_access?(controller, action)
        free_access_action = action.to_s.split('_')[0]
        return true if free_access_action.empty?
        accessing  = {'controller' => controller.to_s, 'action' => action.to_s}
        @session[:user_permissions] ||= @current_user.user_permissions
        @session[:user_permissions].include?(accessing)
      end
    end
  end
end
