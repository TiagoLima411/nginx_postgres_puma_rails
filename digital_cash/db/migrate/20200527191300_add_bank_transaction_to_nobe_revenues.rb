class AddBankTransactionToNobeRevenues < ActiveRecord::Migration[5.0]
  def change
    add_reference :nobe_revenues, :bank_transaction, foreign_key: true, after: :user_id
  end
end
