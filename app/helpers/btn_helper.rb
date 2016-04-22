module BtnHelper
  def login_btn
    render partial: 'application/btn/login'
  end
  
  def back_btn
    render partial: 'application/btn/back'
  end

  # def btn_destroy url, opt = {}
  #   opt.reverse_merge!(
  #     title: I18n.t('destroy'),
  #     confirm: I18n.t('confirm'),
  #     class: ''
  #   )
  #
  #   link_to opt[:title], url, method: :delete, data: { confirm: opt[:confirm] }, class: "btn btn-danger #{opt[:class]}"
  # end
end
