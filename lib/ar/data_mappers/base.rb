module Ar
  module DataMappers
    class Base
      include Singleton

      def map_to_record(repository_class, entity)
        attributes = attributes_from_entity(entity)
        repository_class.new(attributes)
      end

      def map_to_entity(record, entity)
        attributes = attributes_from_record(record)
        entity.class.new(attributes)
      end

      def self.attributes_to_map(*attrs)
        @attributes_to_map = attrs
      end

      def self._attributes_to_map(*attrs)
        @attributes_to_map
      end

      private

      def attributes_from_entity(entity)
        attributes_from(entity)
      end

      def attributes_from_record(record)
        attributes_from(record)
      end

      def attributes_from(object)
        begin
          self.class._attributes_to_map.collect { |attr_key|
            {:"#{attr_key}" => object.send(attr_key)}
          }.reduce({}, :merge)
        rescue => e
          raise StandardError, "#{self.class} -> #{e.message}"
        end
      end

    end
  end
end
