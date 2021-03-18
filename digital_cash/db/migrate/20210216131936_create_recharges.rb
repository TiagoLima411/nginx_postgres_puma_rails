class CreateRecharges < ActiveRecord::Migration[5.0]
  def change
    create_table :recharges do |t|
      t.references :user, foreign_key: true
      t.integer :pagseguro_status, default: 0, null: false
      t.integer :pagseguro_payment_method, default: 0, null: false
      t.integer :gross_value_cents
      t.integer :discount_value_cents
      t.decimal :installment_fee_amount, precision: 5, scale: 2
      t.decimal :intermediation_rate_amount, precision: 5, scale: 2
      t.decimal :intermediation_fee_amount, precision: 5, scale: 2
      t.integer :net_value_cents
      t.integer :extra_value_cents
      t.integer :installment_count
      t.integer :item_count
      t.string :code
      t.string :payment_method_code
      t.string :authorizationCode
      t.string :nsu
      t.string :tid
      t.string :establishment_code
      t.string :acquirer_Name
      t.string :primary_receiver_key
      t.datetime :date
      t.datetime :transaction_date
      t.datetime :last_event_date

      t.timestamps
    end
  end
end
