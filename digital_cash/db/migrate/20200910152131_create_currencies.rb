class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :symbol
      t.string :name
      
      t.timestamps
    end
  end
end
