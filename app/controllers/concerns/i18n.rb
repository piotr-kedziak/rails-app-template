module Concerns::I18n
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  protected
    # set locale
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
  # protected
end
