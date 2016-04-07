require 'rails_helper'

RSpec.describe 'landing/index.html.erb', type: :view do
  include ActionView::Helpers

  it 'should have login link' do
    view.extend BtnHelper
    render
    expect(rendered).to have_link(t('login'))
  end
end
