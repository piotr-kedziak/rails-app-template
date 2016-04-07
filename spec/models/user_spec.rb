require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'auth fields' do
    it { should respond_to(:email) }
    it { should respond_to(:sign_in_count) }
    it { should respond_to(:current_sign_in_at) }
    it { should respond_to(:current_sign_in_ip) }
    it { should respond_to(:last_sign_in_at) }
    it { should respond_to(:last_sign_in_ip) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  describe 'terms field' do
    it { should respond_to(:terms_accepted?) }
    it { expect(User.new).to have_attributes(terms_accepted: true) }
    it { should validate_acceptance_of(:terms_accepted) }
  end
  
  describe 'cookies field' do
    it { should respond_to(:cookies_accepted?) }
    it { expect(User.new).to have_attributes(cookies_accepted: true) }
    it { should validate_acceptance_of(:cookies_accepted) }
  end
end
