require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BtnHelper. For example:
#
# describe BtnHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BtnHelper, type: :helper do
  describe 'login button' do
    it 'renders link' do
      expect(helper.login_btn).to have_link(t('login'))
    end
  end

  describe 'back button' do
    it 'has back link' do
      expect(helper.back_btn).to have_link(t('back'))
    end
  end
end
