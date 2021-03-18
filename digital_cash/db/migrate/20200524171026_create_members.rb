class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.integer :gender
      t.string :mother_name
      t.string :cpf
      t.string :rg
      t.string :phone
      t.string :address
      t.string :zipcode
      t.references :city, foreign_key: true
      t.references :state, foreign_key: true
      t.string :complement
      t.string :number
      t.string :district
      t.string :address_number
      t.string :address_reference

      t.timestamps
    end
  end
end
