module NavHelper
  def show_top_nav?
    user_signed_in?
  end

  def nav_element(locals)
    return if locals.blank?
    render partial: 'nav/element', locals: locals
  end
end
