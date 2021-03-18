require 'rails_helper'
require 'spec_helper'

RSpec.describe Recharge, type: :model do

  before(:context) do
    @recharge = attributes_for(:recharge)
    @user = create(:user)
    @recharge[:user_id] = @user.id
    @response_credit_card = response_credit_card_mock
	end
	
	it "has a valid recharge" do
    expect(build(:recharge)).to be_valid
  end
	
	describe "Recharge validations" do
    # Basic validations
		it { is_expected.to validate_presence_of(:pagseguro_payment_method) }
		it { is_expected.to validate_presence_of(:pagseguro_status) }
		it { is_expected.to validate_numericality_of(:gross_value_cents).is_greater_than_or_equal_to(0) }
		it { is_expected.to validate_numericality_of(:gross_value_cents).only_integer }
		it { is_expected.to validate_numericality_of(:discount_value_cents).only_integer }
		it { is_expected.to validate_numericality_of(:installment_fee_amount) }
		it { is_expected.to validate_numericality_of(:intermediation_rate_amount) }
		it { is_expected.to validate_numericality_of(:intermediation_fee_amount) }
		it { is_expected.to validate_numericality_of(:net_value_cents).is_greater_than_or_equal_to(0) }
		it { is_expected.to validate_numericality_of(:net_value_cents).only_integer }
		it { is_expected.to validate_numericality_of(:extra_value_cents).only_integer }
		it { is_expected.to validate_numericality_of(:installment_count).is_greater_than(0) }
		it { is_expected.to validate_numericality_of(:installment_count).only_integer }
		it { is_expected.to validate_numericality_of(:item_count).is_greater_than(0) }
		it { is_expected.to validate_numericality_of(:item_count).only_integer }

    # Format validations
		it { is_expected.to allow_value(0).for(:gross_value_cents) }
		it { is_expected.to_not allow_value(-1).for(:gross_value_cents) }
		it { is_expected.to allow_value(0).for(:discount_value_cents) }
		it { is_expected.to allow_value(0.0).for(:installment_fee_amount) }
		it { is_expected.to allow_value(0.0).for(:intermediation_rate_amount) }
		it { is_expected.to allow_value(0.0).for(:intermediation_fee_amount) }
		it { is_expected.to allow_value(0).for(:net_value_cents) }
		it { is_expected.to_not allow_value(-1).for(:net_value_cents) }
		it { is_expected.to allow_value(0).for(:extra_value_cents) }
		it { is_expected.to_not allow_value(-1).for(:extra_value_cents) }
		it { is_expected.to_not allow_value(0).for(:installment_count) }
		it { is_expected.to allow_value(1).for(:installment_count) }
		it { is_expected.to_not allow_value(0).for(:item_count) }
		it { is_expected.to allow_value(1).for(:item_count) }

  end

  context 'Associations' do
		it { is_expected.to belong_to(:user) }
		it { is_expected.to have_many(:pagseguro_histories) }
	end
	
  context 'Class Methods' do
    it 'Should create a credit card transaction' do
      recharge = Recharge.generate_credit_cad(@response_credit_card, @user)
      expect(recharge.pagseguro_payment_method).to eq('credit_card')
    end

    it 'Should create a billet transaction' do
      recharge = Recharge.generate_billet(@recharge)
      expect(recharge.pagseguro_payment_method).to eq('billet')
    end

    it 'Should create a debit online transaction' do
      recharge = Recharge.generate_debit_online(@recharge)
      expect(recharge.pagseguro_payment_method).to eq('debit_online')
    end
  end

  context 'Instance Methods' do
		it { expect { create(:recharge) }.to change { PagseguroHistory.all.size }.by(1) }
	
		it 'Should generate extract when pagseguro_status paid' do
			recharge = Recharge.generate_credit_cad(@response_credit_card, @user)
			expect(recharge.pagseguro_status).to eq('paid')
			
			history = PagseguroHistory.where(recharge: recharge).last
			expect(history.recharge).to eq(recharge)
			expect(history.status).to eq(recharge.pagseguro_status)

			income = Income.find_by(reference_id: recharge.id)
			expect(income.value_cents).to eq(recharge.net_value_cents)
			expect(income.reference_id).to eq(recharge.id)
			expect(income.user_id).to eq(@user.id)

			extract = AccountExtract.find_by(reference_id: income.id)
			expect(extract.reference_id).to eq(income.id)
			expect(extract.user_id).to eq(@user.id)
    	expect(extract.value_cents).to eq(income.value_cents)
			expect(extract.account_balance).to eq(income.user.account_balance)
    	expect(extract.balance_cents).to eq(income.user.account_balance.available_value_cents - income.value_cents)
    	expect(extract.description).to eq(income.description)
    	expect(extract.type_register).to eq('credit')
		end


  end

  private

  def response_credit_card_mock
		{"transaction"=>
			{   
				"date"=>"2021-02-12T17:16:30.000-03:00",
				"code"=>"A07D4887-19B8-49F3-95DE-B727D5572C2E",
				"type"=>"1",
				"status"=>"3",
				"lastEventDate"=>"2021-02-12T17:16:30.000-03:00",
				"paymentMethod"=>{"type"=>"1", "code"=>"101"},
				"grossAmount"=>"11.00",
				"discountAmount"=>"0.00",
				"creditorFees"=>{"installmentFeeAmount"=>"0.40", "intermediationRateAmount"=>"0.40", "intermediationFeeAmount"=>"0.55"},
				"netAmount"=>"9.65",
				"extraAmount"=>"0.00",
				"installmentCount"=>"2",
				"itemCount"=>"1",
				"items"=>{"item"=>{"id"=>"1", "description"=>"Recargar em conta", "quantity"=>"1", "amount"=>"11.00"}},
				"sender"=>
					{"name"=>"Tiago de Lima Alves", "email"=>"tiago@sandbox.pagseguro.com.br", "phone"=>{"areaCode"=>"82", "number"=>"999999999"}, "documents"=>{"document"=>{"type"=>"CPF", "value"=>"16261677026"}}},
				"shipping"=>
					{"address"=>{"street"=>"Conj. Celly Loureiro, Qd - E", "number"=>"71", "complement"=>nil, "district"=>"Benedito Bentes", "city"=>"Maceió", "state"=>"AL", "country"=>"BRA", "postalCode"=>"57084000"},
					"type"=>"3",
					"cost"=>"0.00"},
				"gatewaySystem"=>
					{"type"=>"cielo",
					"rawCode"=>{"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xsi:nil"=>"true"},
					"rawMessage"=>{"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xsi:nil"=>"true"},
					"normalizedCode"=>{"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xsi:nil"=>"true"},
					"normalizedMessage"=>{"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xsi:nil"=>"true"},
					"authorizationCode"=>"0",
					"nsu"=>"0",
					"tid"=>"0",
					"establishmentCode"=>"1056784170",
					"acquirerName"=>"CIELO"},
				"primaryReceiver"=>{"publicKey"=>"PUB34A66B6F667A4B20A279BBF5C810C120"}
			}
		}
	end
end
