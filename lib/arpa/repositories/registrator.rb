module Arpa
  module Repositories
    module Registrator
      include Base

      def create(entity)
        save(entity, &:save!)
      end

      def update(entity)
        save(entity) do |record|
          record.updated_at = Time.new.utc
          attributes        = record.attributes.except('id', 'created_at')

          repository_class.update(entity.id, attributes)

          record.reload
          record.reload
          post_update(entity, record)
        end
      end

      private

      def save(entity)
        record = mapper_instance.map_to_record(entity)
        begin
          yield(record)
        rescue ActiveRecord::RecordInvalid => invalid
          raise Arpa::Exceptions::RecordInvalid.new(message: invalid.message, errors: invalid.record.errors)
        end

        mapper_instance.map_to_entity(record)
      end

      def post_update(entity, record); end
    end
  end
end
