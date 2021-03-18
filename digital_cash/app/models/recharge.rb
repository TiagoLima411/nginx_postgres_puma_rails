class Recharge < ApplicationRecord
	belongs_to :user
	has_many :pagseguro_histories

	validates :pagseguro_payment_method, presence: true
	validates :pagseguro_status, presence: true

	validates_numericality_of :gross_value_cents, only_integer: true, greater_than_or_equal_to: 0
	validates_numericality_of :discount_value_cents, only_integer: true
	validates_numericality_of :net_value_cents, only_integer: true, greater_than_or_equal_to: 0
	validates_numericality_of :extra_value_cents, only_integer: true, greater_than_or_equal_to: 0
	validates_numericality_of :installment_count, only_integer: true, greater_than: 0
	validates_numericality_of :item_count, only_integer: true, greater_than: 0
	validates_numericality_of :installment_fee_amount, decimal: true
	validates_numericality_of :intermediation_rate_amount, decimal: true
	validates_numericality_of :intermediation_fee_amount, decimal: true

	after_save :generate_extract, if: :saved_change_to_pagseguro_status?
	after_save :generate_history, if: :saved_change_to_pagseguro_status?

	enum pagseguro_payment_method: %i[others credit_card billet debit_online]
	enum pagseguro_status: %i[undefined awaiting_payment in_analysis paid available in_dispute returned canceled]
	attr_accessor :description

	def self.generate_credit_cad(args, user)
		recharge = Recharge.new
		transaction = args['transaction']
		recharge.user = user
		recharge.pagseguro_status = transaction['status'].to_i
		recharge.pagseguro_payment_method = transaction['paymentMethod']['type'].to_i
		
		recharge.gross_value_cents = to_cents(transaction['grossAmount'])
		recharge.discount_value_cents = to_cents(transaction['discountAmount'])
		recharge.installment_fee_amount = transaction['creditorFees']['installmentFeeAmount'].to_f
		recharge.intermediation_rate_amount = transaction['creditorFees']['intermediationRateAmount'].to_f
		recharge.intermediation_fee_amount = transaction['creditorFees']['intermediationFeeAmount'].to_f
		recharge.net_value_cents = to_cents(transaction['netAmount'])
		recharge.extra_value_cents = to_cents(transaction['extraAmount'])
		recharge.installment_count = transaction['installmentCount'].to_i
		recharge.item_count = transaction['itemCount'].to_i
		recharge.code = transaction['code']
		recharge.payment_method_code = transaction['paymentMethod']['code']
		recharge.authorizationCode = transaction['gatewaySystem']['authorizationCode']
		recharge.nsu = transaction['gatewaySystem']['nsu']
		recharge.tid = transaction['gatewaySystem']['tid']
		recharge.establishment_code = transaction['gatewaySystem']['establishmentCode']
		recharge.acquirer_Name = transaction['gatewaySystem']['acquirerName']
		recharge.primary_receiver_key = transaction['primaryReceiver']['publicKey']
		recharge.date = transaction['date'].to_time
		recharge.transaction_date = transaction['date'].to_time
		recharge.last_event_date = transaction['lastEventDate'].to_time
		recharge.description = transaction['items']['item']['description']

		recharge if recharge.save
	end

	def self.generate_billet(recharge)
		recharge = Recharge.new(recharge)
		recharge.billet!

		recharge if recharge.save
	end

	def self.generate_debit_online(recharge)
		recharge = Recharge.new(recharge)
		recharge.debit_online!

		recharge if recharge.save
	end

	private

	def self.to_cents(value)
		(value.to_f * 100).to_i
	end

	def generate_extract
		Income.generate_credit_card(self) if paid?
  end

	def generate_history
		PagseguroHistory.generate(self)
	end
end
