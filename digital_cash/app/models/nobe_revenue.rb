class NobeRevenue < ApplicationRecord
  belongs_to :user
  belongs_to :bank_transaction

  def self.generate(bank_transaction)

    nobe_revenue = NobeRevenue.new
    nobe_revenue.user = bank_transaction.user
    nobe_revenue.bank_transaction = bank_transaction
    nobe_revenue.description = "Transferência de #{bank_transaction.user.member.name} para #{bank_transaction.benefited_user.member.name}"
    nobe_revenue.value_cents = bank_transaction.spread_fee_cents
    nobe_revenue.save

  end

end
