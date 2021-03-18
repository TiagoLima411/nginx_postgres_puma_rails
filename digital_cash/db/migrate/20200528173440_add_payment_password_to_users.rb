class AddPaymentPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :payment_password, :string, after: :encrypted_password
  end
end
