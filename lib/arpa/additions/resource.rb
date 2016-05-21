module Arpa
  module Additions
    module Resource

      def self.included(base)
        base.helper_method :has_access?
      end

      def has_access?(resource, action)
        return unless has_session_or_current_user?
        verifier.has_access?(resource, action)
      end

      def reset_permissions
        verifier.reset_permissions
      end

      def verifier
        @verifier ||= Arpa::Services::Verifier.new(session, current_user)
      end

      private

      def has_session_or_current_user?
        verified_session      = try(:session)
        verified_current_user = try(:current_user)
        return true if verified_session && verified_current_user
        log = Logger.new(STDOUT)
        log.warn("The ApplicationController must has a attribute or method 'session'") unless verified_session
        log.warn("The ApplicationController must has a attribute or method 'current_user'") unless verified_current_user
        false
      end

    end
  end
end
