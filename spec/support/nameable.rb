shared_examples 'nameable' do
  describe '#name' do
    it { is_expected.to respond_to(:name) }

    context 'with name' do
      let!(:name) { 'Test name' }
      subject { described_class.new(name: name) }

      it { expect(subject.to_s).to eq(subject.name) }
      it { expect(subject.to_s).to eq(name) }
    end
  end
end
