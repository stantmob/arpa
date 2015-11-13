module Ar
  module Repositories
    module Registrator
      include Base

      def create entity
        record = mapper_instance.map_to_record(repository_class, entity)
        begin
          record.save!
        rescue ActiveRecord::RecordInvalid => invalid
          raise Ar::Exceptions::RecordInvalid.new(message: invalid.message, errors: invalid.record.errors)
        end

        mapper_instance.map_to_entity(record, entity)
      end

    end
  end
end

