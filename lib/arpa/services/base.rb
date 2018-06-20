module Arpa
  module Services
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      def manager_action(callback)
        begin_transaction do
          result = yield
          callback[:success].call result
        rescue StandardError => e
          callback[:fail].call e
        end
      end

      private

      def begin_transaction
        self.class._repository_transaction.transaction do
          yield
        end
      end

      module ClassMethods
        def repository_transaction(repository_transaction_class)
          @repository_transaction = repository_transaction_class
        end

        def _repository_transaction
          @repository_transaction ||= 'ActiveRecord::Base'
          @repository_transaction.constantize
        end
      end
    end
  end
end
