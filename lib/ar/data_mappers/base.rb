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

      def self.attrs_to_record(*attrs)
        @attrs_to_record = attrs
      end

      def self.attrs_to_entity(*attrs)
        @attrs_to_entity = attrs
      end

      def self._attributes_to_map
        @attributes_to_map
      end

      def self._attrs_to_record
        @attrs_to_record
      end

      def self._attrs_to_entity
        @attrs_to_entity
      end

      private

      def attributes_from_entity(entity)
        attrs_to_record = self.class._attrs_to_record
        attributes_from(entity, attrs_to_record)
      end

      def attributes_from_record(record)
        attrs_to_entity = self.class._attrs_to_entity
        attributes_from(record, attrs_to_entity)
      end

      def attributes_from(object, attrs_to_map)
        attrs_to_map ||= self.class._attributes_to_map
        begin
          attrs_to_map.collect { |attr_key|
            {:"#{attr_key}" => object.send(attr_key)}
          }.reduce({}, :merge)
        rescue => e
          raise StandardError, "#{self.class} -> #{e.message}"
        end
      end

    end
  end
end
