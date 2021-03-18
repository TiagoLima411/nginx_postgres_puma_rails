class AccountBalance < ApplicationRecord
  belongs_to :user

  monetize :available_value_cents
  
  def self.generate(user)
    balance = AccountBalance.new
    balance.user = user
    balance.available_value_cents = 0
    balance.save
  end
end
