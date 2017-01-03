module Layout
  extend ActiveSupport::Concern

  included do
    # don't render layout on xhr request
    # (ex. via ajax $(...).load(...) call)
    layout :choose_layout
  end

  protected

  def choose_layout
    return false    if request.xhr?
    return 'devise' if devise_controller? && !user_signed_in?
    'application'
  end
end
