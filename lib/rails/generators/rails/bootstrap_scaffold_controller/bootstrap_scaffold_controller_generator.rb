require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Rails
  module Generators
    class BootstrapScaffoldControllerGenerator < ScaffoldControllerGenerator
      source_root File.expand_path("../templates", __FILE__)

      def create_localization_files
        template "localization.rb", File.join('config/locales', controller_class_path, "#{controller_file_name}/pl.yml")
      end
    end
  end
end
