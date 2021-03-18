require 'rails_helper'

RSpec.describe PagseguroHistory, type: :model do
  before(:context) do
    @recharge = create(:recharge)
  end

  context 'Validates' do
  end

  context 'Associations' do
    it { is_expected.to belong_to(:recharge)}
  end

  context 'Class Methods' do
    it 'Should create a history' do
      history = PagseguroHistory.generate(@recharge)
      expect(history.status).to eq(@recharge.pagseguro_status)
    end
  end

  context 'Instance Methods' do
    it { expect { create(:recharge) }.to change { PagseguroHistory.all.size }.by(1) }
  end
end
