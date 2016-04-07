module LayoutHelper
  def layout_body_css_class
    styles = []
    styles << 'devise'    if devise_controller?
    styles << 'with_nav'  if show_top_nav?

    # return styles string
    styles.join ' '
  end
end
