pl:
  <%= namespaced_file_path if namespaced? %><%= plural_table_name.downcase %>:
    create:
      created: Utworzono <%= class_name %>
    update:
      updated: Zaktualizowano dane
    destroy:
      deleted: Usunięto <%= class_name %>
    form:
    new:
      header: Dodawanie <%= class_name %>
    edit:
      header: Aktualizacja <%= class_name %>
    show:
    index:
      header: Lista <%= class_name %>
      new: Dodaj nowy
<% attributes_names.each do |name| -%>
      <%= name %>: <%= name %>
<% end -%>
      empty:
        info: Brak <%= class_name %>
        add_first: Dodaj pierwszy
  activerecord:
    models:
      <%= namespaced_file_path if namespaced? %><%= singular_table_name %>: <%= class_name %>
    attributes:
      <%= namespaced_file_path if namespaced? %><%= singular_table_name %>:
<% attributes_names.each do |name| -%>
        <%= name %>: <%= name %>
<% end -%>
