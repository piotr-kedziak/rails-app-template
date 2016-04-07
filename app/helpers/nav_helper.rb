module NavHelper
  def show_top_nav?
    user_signed_in?
  end

  def nav_element options
    return if options.blank?

    locals = {
      name: options[:name],
      path: options[:path],
      id: options[:id],
      badge: options[:badge]
    }

    render partial: 'nav/element', locals: locals
  end
end
