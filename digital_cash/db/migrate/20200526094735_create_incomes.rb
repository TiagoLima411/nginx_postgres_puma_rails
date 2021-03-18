class CreateIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :incomes do |t|
      t.references :user, foreign_key: true
      t.integer :intype
      t.integer :value_cents
      t.string :description
      
      t.timestamps
    end
  end
end
