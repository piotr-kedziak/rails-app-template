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

  describe 'name' do
    it { should respond_to(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(150) }
    it { expect(User.new(name: 'Mike').to_s).to eq("Mike") }
  end

  describe 'name or email method' do
    it { should respond_to(:name_or_email) }
    it 'returns email in to_s when name is blank' do
      email = 'user@example.com'
      expect(User.new(email: email, name: '').to_s).to eq(email)
    end
    it 'returns name in to_s if user has name' do
      email = 'user@example.com'
      name  = 'John Nash'
      expect(User.new(email: email, name: name).to_s).to eq(name)
    end
  end
end
