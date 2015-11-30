module Arpa
  module Generators
    class TesGenerator < Rails::Generators::Base
      source_root File.expand_path("..", __FILE__)

      def tes_t
        require 'pry'; binding.pry
      end

    end
  end
end
