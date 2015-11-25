module Arpa
  module DataMappers
    class Base
      include Singleton

      def map_to_record(entity, options={})
        options[:map_association_to] ||= :map_to_record
        attrs_to_record = self.class._attrs_to_record
        attributes      = attributes_from(entity, attrs_to_record, options)
        self.class._repository_class.new(attributes)
      end

      def map_to_entity(record, options={})
        options[:map_association_to] ||= :map_to_entity
        attrs_to_entity = self.class._attrs_to_entity
        attributes      = attributes_from(record, attrs_to_entity, options)
        self.class._entity_class.new(attributes)
      end

      private

      def attributes_from(object, attrs_to_map, options={})
        options[:map_association_to] = options.fetch(:map_association_to, :map_to_entity)
        options[:map_association]    = options.fetch(:map_association, true)

        attrs_to_map ||= self.class._attributes_to_map

        begin
           build_hash_attributes(attrs_to_map, object, options)
        rescue => e
          raise StandardError, "#{self.class} -> #{e.message}"
        end
      end

      def build_hash_attributes(attributes_to_map, object, options)
        builder_attribute = build_hash_attribute.curry.(object, options)

        attributes_to_map.collect { |attr_key|
          builder_attribute.(attr_key)
        }.reduce({}, :merge)
      end

      def build_hash_attribute
        -> (object, options, attr_key) {
          if attr_key.kind_of?(Hash)
            key   = attr_key.keys.first
            value = association_value(object, attr_key, options)
          else
            key   = attr_key
            value = object.send(attr_key)
          end
          {:"#{key}" => value}
        }
      end

      def association_value(object, attr_key, options)
        key          = attr_key.keys.first
        object_value = object.send(key)

        return object_value unless options[:map_association]

        mapper = attr_key[key][:mapper].constantize.instance

        if object_value.try(:size)
          object_value.collect do |obj|
            mapper.send(options[:map_association_to], obj, {map_association: false})
          end
        else
          mapper.send(options[:map_association_to], object_value, {map_association: false})
        end
      end

      # --- Classes Methods ---

      def self.entity_class(entity_class)
        @entity_class = entity_class
      end

      def self._entity_class
        @entity_class.constantize
      end

      def self.repository_class(repository_class)
        @repository_class = repository_class
      end

      def self._repository_class
        @repository_class.constantize
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

    end
  end
end
