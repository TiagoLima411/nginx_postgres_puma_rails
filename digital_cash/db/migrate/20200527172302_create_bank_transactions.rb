class CreateBankTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_transactions do |t|
      t.references :user, foreign_key: true
      t.integer :benefited_user_id
      t.integer :spread_fee_cents
      t.integer :net_value_cents
      t.integer :gross_value_cents
      t.string :description
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
