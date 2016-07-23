require 'rails/generators/erb'
require 'rails/generators/resource_helpers'

module Erb # :nodoc:
  module Generators # :nodoc:
    class ScaffoldGenerator < Base # :nodoc:
      include Rails::Generators::ResourceHelpers

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def create_root_folder
        empty_directory File.join("app/views", controller_file_path)
      end

      def copy_view_files
        available_views.each do |view|
          formats.each do |format|
            filename = filename_with_extensions(view, format)
            template filename, File.join("app/views", controller_file_path, filename)
          end
        end

        create_list_partial
      end

      # creates list/_{model}.html.erb file
      # file name is based on singular_table_name
      def create_list_partial
        formats.each do |format|
          template = filename_with_extensions('list/_element', format)
          filename = filename_with_extensions("list/_#{singular_table_name}", format)
          template template, File.join("app/views", controller_file_path, filename)
        end
      end

      protected

      def available_views
        %w(index edit show new _form _empty _list)
      end
    end
  end
end
