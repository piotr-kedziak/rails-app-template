require 'rails/generators/rails/scaffold/scaffold_generator'

module Erb
  module Generators
    class BootstrapScaffoldGenerator < ScaffoldGenerator
      def available_views
        super + %w( _empty )
      end
    end
  end
end
