module Arpa
  module Generators
    class ArpaGenerator < Rails::Generators::Base
      source_root File.expand_path("..", __FILE__)

      def ttest
        require 'pry'; binding.pry
      end

    end
  end
end
