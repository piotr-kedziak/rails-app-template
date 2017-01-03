module Concerns
  module Devise
    extend ActiveSupport::Concern

    included do
      helper_method :logged_in?, :signed_in?
      helper_method :my, :me

      # alias for devise methods
      alias_method :my, :current_user
      alias_method :me, :current_user
      # alias for devise methods
      alias_method :signed_in?, :user_signed_in?
      alias_method :logged_in?, :user_signed_in?
    end
  end
end
