module FormHelper
  def show_form_errors_if_any(model)
    return if model.blank? || model.errors.blank?

    render 'form_errors', errors: model.errors
  end
end
