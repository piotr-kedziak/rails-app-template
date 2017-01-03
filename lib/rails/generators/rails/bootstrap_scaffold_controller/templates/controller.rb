<% if namespaced? -%>
require_dependency '<%= namespaced_file_path %>/application_controller'

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= plural_table_name %>, only: :index
  before_action :set_<%= singular_table_name %>, only: %i(show edit update destroy), if: :<%= singular_table_name %>_choosed?
  before_action :initialize_<%= singular_table_name %>, only: :new
  before_action :initialize_<%= singular_table_name %>_for_create, only: :create

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: <%= "t('.created')" %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: <%= "t('.updated')" %>
    else
      render :edit
    end
  end

  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: <%= "t('.deleted')" %>
  end

  private

  def set_<%= plural_table_name %>
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def initialize_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def initialize_<%= singular_table_name %>_for_create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
  end

  def <%= singular_table_name %>_choosed?
    params[:id].present?
  end

  def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
    params[:<%= singular_table_name %>]
    <%- else -%>
    params.require(:<%= singular_table_name %>).permit(
<% attributes_names.each do |name| -%>
      <%= ":#{name}," %>
<% end -%>
    )
    <%- end -%>
  end
end
<% end -%>
