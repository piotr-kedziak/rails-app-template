shared_examples 'devise_authenticable' do
  describe 'devise auth fields' do
    describe '#email' do
      it { is_expected.to respond_to(:email) }
    end

    describe '#sign_in_count' do
      it { is_expected.to respond_to(:sign_in_count) }
    end

    describe '#current_sign_in_at' do
      it { is_expected.to respond_to(:current_sign_in_at) }
    end

    describe '#current_sign_in_ip' do
      it { is_expected.to respond_to(:current_sign_in_ip) }
    end

    describe '#last_sign_in_at' do
      it { is_expected.to respond_to(:last_sign_in_at) }
    end

    describe '#last_sign_in_ip' do
      it { is_expected.to respond_to(:last_sign_in_ip) }
    end
  end
end
