class Income < ApplicationRecord
  belongs_to :user

  after_create :generate_history
  before_save :update_account_balance, if: -> { new_record? }

  monetize :value_cents
  
  enum intype: %i[deposit transfer recharge_credit_card]

  scope :incomes_in_month, ->(date) {
    where(created_at: [date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day])
  }

  def self.generate_credit(bank_transaction)
    net_value = format_value_cents(bank_transaction.net_value_cents) 

    income = Income.new
    income.user = bank_transaction.benefited_user
    income.intype = Income.intypes[:transfer]
    income.value_cents = bank_transaction.net_value_cents
    income.description = "Valor recebido de R$#{net_value} de #{bank_transaction.user.member.name}"
    income.reference_id = bank_transaction.id
    income.save

  end

  def self.generate_credit_card(recharge_credit_card)
    net_value = format_value_cents(recharge_credit_card.net_value_cents) 

    income = Income.new
    income.user = recharge_credit_card.user
    income.intype = :recharge_credit_card
    income.value_cents = recharge_credit_card.net_value_cents
    income.description = recharge_credit_card.description
    income.reference_id = recharge_credit_card.id

    income.save

  end
  
  def generate_history
    AccountExtract.generate_credit(self)
  end

  def update_account_balance
    balance = AccountBalance.find_by(user_id: self.user_id)
    balance.with_lock do
      if deposit? || transfer? || recharge_credit_card?
        balance.update(available_value_cents: balance.available_value_cents + self.value_cents)
      end
    end
  end

  private

  def self.format_value_cents(value_cents)
    value = '%.2f' % (value_cents.to_f / 100)
    return value.gsub('.', ',')
  end
end
