module Ar
  module Repositories
    module Registrator

      def create entity
        record = mapper_instance.map_to_record(repository_class, entity)
        begin
          record.save!
        rescue ActiveRecord::RecordInvalid => invalid
          raise Ar::Exceptions::RecordInvalid.new(message: invalid.message, errors: invalid.record.errors)
        end

        mapper_instance.map_to_entity(record, entity)
      end

      def mapper_instance
        raise NotImplementedError, "This #{self.class} cannot respond :mapper_instance"
      end

      def repository_class
        raise NotImplementedError, "This #{self.class} cannot respond :repository_class"
      end

    end
  end
end

