module Ar
  module Additions
    module Resource

      def self.included(base)
        base.helper_method :has_access?
      end

      def has_access?(controller, action)
        @verifier ||= Ar::Services::Verifier.new(session, current_user)
        @verifier.has_access?(controller, action)
      end

      def session
        raise NotImplementedError, "This #{self.class} cannot respond :session"
      end

      def current_user
        raise NotImplementedError, "This #{self.class} cannot respond :current_user"
      end

    end
  end
end
