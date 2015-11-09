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
        attrs = Hash.new

        begin
          self.class._attributes_to_map.each do |attribute|
            attrs[attribute] = entity.send(attribute)
          end
        rescue => e
          raise StandardError, "#{self.class} -> #{e.message}"
        end

        attrs
      end

      def attributes_from_record(record)
        record.attributes.select { |attr| self.class._attributes_to_map.include?(attr.to_sym) }
      end

    end
  end
end
