class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true 
      t.references :bank, foreign_key: true
      t.boolean  :active, default: true
      t.string :agency_number
      t.string :account_number
      t.integer :account_type

      t.timestamps
    end
  end
end
