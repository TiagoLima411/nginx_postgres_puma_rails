require 'rails_helper'
#require 'rspec/rails'

RSpec.describe User, type: :model do
  context 'Validates' do
    it 'user must be valid' do
      user = create(:user)
      expect(user).to be_valid
    end
    it { expect{ create(:user) }.to change{User.all.size}.by(1) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:password) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:member) }
  end

  context 'Instance Methods' do
    it 'user must create payment password' do
      member = create(:member)
      member.user.set_payment_password(Faker::Internet.password)
      expect(member.user.payment_password).not_to be_nil
    end

    it 'should check payment password' do
      password = Faker::Internet.password
      member = create(:member)
      member.user.set_payment_password(password)
      result = User.valid_payment_password?(member.cpf, password)
      expect(result).to be_kind_of(User)
    end

    it 'user should create account balance' do
      member = create(:member)
      expect(member.user.account_balance).to be_kind_of(AccountBalance)
    end

    it 'the user must return null when sending incorrect payment password' do
      password = Faker::Internet.password
      member = create(:member)
      member.user.set_payment_password(password)
      result = User.valid_payment_password?(member.cpf, '')
      expect(result).to be_nil
    end
  end
end
