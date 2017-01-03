shared_examples 'terms_acceptable' do
  describe '#terms_accepted?' do
    it { is_expected.to respond_to(:terms_accepted?) }
    it { expect(described_class.new).to have_attributes(terms_accepted: true) }
    it { is_expected.to validate_acceptance_of(:terms_accepted) }
  end
end
