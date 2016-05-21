module Arpa
  module Entities
    class Resource

      attr_reader :id, :full_name, :name, :created_at, :updated_at, :actions

      def initialize(attrs = {})
        attrs = attrs.with_indifferent_access

        @id         = attrs[:id]
        @full_name  = attrs[:full_name]
        @name       = attrs[:name]
        @created_at = attrs[:created_at]
        @updated_at = attrs[:updated_at]
        @actions    = attrs[:actions].present? ? attrs[:actions] : []
      end

      def build_correct_name
        name  = remove_word(full_name)
        @name = adjust_name(name)
      end

      private

      def adjust_name(name)
        parts_of_name   = name.split '::'
        refactored_name = String.new

        parts_of_name.each_with_index do |part, index|
          refactored_name << '/' if index > 0
          refactored_name << change_to_snake_case(part)
        end

        refactored_name
      end

      def remove_word(word, word_to_delete = 'Controller')
        word = "#{word}del" if word.include?(word_to_delete)
        word.slice!("#{word_to_delete}del")
        word
      end

      def change_to_snake_case(name)
        parts_of_name   = name.split(/(?=[A-Z])/) # Split at CamelCase
        refactored_name = String.new

        parts_of_name.each_with_index do |part, index|
          part.downcase!
          refactored_name << '_' if index > 0
          refactored_name << part
        end

        refactored_name
      end

    end
  end
end
