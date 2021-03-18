class CreateCryptoCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :crypto_currencies do |t|
      t.string :coin_id
      t.string :symbol
      t.string :name

      t.timestamps
    end
  end
end
