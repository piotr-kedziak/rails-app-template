require 'rails_helper'

RSpec.describe User, type: :model do
  it_behaves_like 'devise_authenticable'
  it_behaves_like 'nameable'
  it_behaves_like 'terms_acceptable'
  it_behaves_like 'timestampable'

  describe '#name' do
    it { is_expected.to validate_length_of(:name).is_at_most(40) }
  end

  describe '#name_or_email' do
    it { is_expected.to respond_to(:name_or_email) }

    context 'without name' do
      subject { build(:user, name: '') }
      it { expect(subject.to_s).to eq(subject.email) }
    end

    context 'with name' do
      subject { build(:user, name: 'John') }
      it { expect(subject.to_s).to eq(subject.name) }
    end
  end
end
