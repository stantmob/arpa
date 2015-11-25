module Arpa
  module Repositories
    module Base

      def mapper_instance
        raise NotImplementedError, "This #{self.class} cannot respond :mapper_instance"
      end

      def repository_class
        raise NotImplementedError, "This #{self.class} cannot respond :repository_class"
      end

    end
  end
end
