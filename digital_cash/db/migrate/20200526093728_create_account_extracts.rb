class CreateAccountExtracts < ActiveRecord::Migration[5.0]
  def change
    create_table :account_extracts do |t|
      t.references :user, foreign_key: true
      t.references :account_balance, foreign_key: true
      t.integer :reference_id
      t.integer :value_cents
      t.integer :balance_cents
      t.string :description
      t.integer :type_register

      t.timestamps
    end
  end
end
