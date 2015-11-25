module Arpa
  module Services
    module Base

      def self.included(base)
        base.extend ClassMethods
      end

      def manager_action callback, &block
        begin_transaction do
          begin
            result = block.call
            callback[:success].call result
          rescue => e
            callback[:fail].call e
          end
        end
      end

      private

      def begin_transaction
        self.class._repository_transaction.transaction do
          yield
        end
      end

      module ClassMethods
        def repository_transaction repository_transaction_class
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
