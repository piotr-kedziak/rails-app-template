module DeviseHelper
  def devise_error_messages!
    return unless devise_error_messages?

    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    render partial: 'form_errors', locals: { errors: resource.errors }
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end
