require 'rails_helper'
#require 'rspec/rails'

RSpec.describe Member, type: :model do

  context 'Validates' do
    it 'Member must be valid' do
      member = create(:member)
      expect(member.user).to be_kind_of(User)
    end

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:address_number) }
    it { is_expected.to validate_presence_of(:district) }
    it { is_expected.to validate_presence_of(:zipcode) }
  end

  context 'Associations' do
    it { is_expected.to have_one(:user) }
    it { is_expected.to belong_to(:city) }
    it { is_expected.to belong_to(:state) }
  end

end
