module Ar
  module Entities
    class Resource

      attr_reader :full_name, :name

      def initialize(attrs = {})
        @full_name = attrs[:full_name]

        build_name
      end

      private

      def build_name
        name  = remove_word(full_name)
        @name = adjust_name(name)
      end

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
