module Layout
  extend ActiveSupport::Concern

  included do
    # don't render layout on xhr request
    # (ex. via ajax $(...).load(...) call)
    layout :choose_layout
  end

  protected
    # we need to choose layout :)
    def choose_layout
      return false    if request.xhr?
      return 'devise' if devise_controller? && ! user_signed_in?
      return 'application'
    end
  # protected
end
