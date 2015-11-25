module Arpa
  module Exceptions
    class RecordInvalid < StandardError
      attr_reader :errors

      def initialize(args)
        super(args[:message])
        @errors = args[:errors]
      end

    end
  end
end
