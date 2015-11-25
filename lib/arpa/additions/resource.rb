module Arpa
  module Additions
    module Resource

      def self.included(base)
        base.helper_method :has_access?
      end

      def has_access?(resource, action)
        return unless has_session_or_current_user?
        @verifier ||= Arpa::Services::Verifier.new(session, current_user)
        @verifier.has_access?(resource, action)
      end

      private

      def has_session_or_current_user?
        sess   = try(:session)
        c_user = try(:current_user)
        return true if sess && c_user
        log = Logger.new(STDOUT)
        log.warn("The ApplicationController must has a attribute or method 'session'") unless sess
        log.warn("The ApplicationController must has a attribute or method 'current_user'") unless c_user
        false
      end

    end
  end
end
