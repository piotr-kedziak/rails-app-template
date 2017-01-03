shared_examples 'timestampable' do
  describe '#created_at' do
    it { is_expected.to respond_to(:created_at) }
  end

  describe '#updated_at' do
    it { is_expected.to respond_to(:updated_at) }
  end
end
