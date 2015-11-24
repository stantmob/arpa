module Ar
  module DataMappers
    class Base
      include Singleton

      def map_to_record(repository_class, entity, options={})
        attributes = attributes_from_entity(entity, options)
        repository_class.new(attributes)
      end

      def map_to_entity(record, entity, options={})
        attributes = attributes_from_record(record, options)
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

      def attributes_from_entity(entity, options={})
        attrs_to_record = self.class._attrs_to_record
        attributes_from(entity, attrs_to_record, options)
      end

      def attributes_from_record(record, options={})
        attrs_to_entity = self.class._attrs_to_entity
        attributes_from(record, attrs_to_entity, options)
      end

      # TODO: Improve way to mapper entity to record with associations

      def attributes_from(object, attrs_to_map, options={})
        map_association = options.fetch(:map_association, true)
        attrs_to_map ||= self.class._attributes_to_map
        begin
          attrs_to_map.collect { |attr_key|
            if attr_key.kind_of?(Hash)
              key   = attr_key.keys.first
              value = association_value(object, attr_key, map_association)
            else
              key   = attr_key
              value = object.send(attr_key)
            end

            {:"#{key}" => value}

          }.reduce({}, :merge)
        rescue => e
          raise StandardError, "#{self.class} -> #{e.message}"
        end
      end

      def association_value(object, attr_key, map_association)
        key          = attr_key.keys.first
        mapper       = attr_key[key][:mapper].constantize.instance
        entity       = attr_key[key][:entity].constantize.new
        object_value = object.send(key)

        return object_value unless map_association

        if object_value.try(:size)
          return object_value.collect do |obj|
            mapper.map_to_entity(obj, entity, {map_association: false})
          end
        else
          return mapper.map_to_entity(object_value, entity, {map_association: false})
        end
      end

    end
  end
end
