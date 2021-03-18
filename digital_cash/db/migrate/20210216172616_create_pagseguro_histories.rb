class CreatePagseguroHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :pagseguro_histories do |t|
      t.references :recharge, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
