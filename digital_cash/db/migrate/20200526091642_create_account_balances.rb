class CreateAccountBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :account_balances do |t|
      t.references :user, foreign_key: true
      t.integer :available_value_cents

      t.timestamps
    end
  end
end
