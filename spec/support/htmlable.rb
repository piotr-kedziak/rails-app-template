shared_examples 'htmlable' do
  describe '#html_id' do
    it { is_expected.to respond_to(:html_id) }

    describe 'contains object id and class' do
      subject { create(described_class.to_s.downcase.to_sym) }

      it { expect(subject.html_id).to include(subject.id.to_s) }
      it { expect(subject.html_id).to include(subject.class.name.parameterize) }
    end
  end
end
