class CreateNobeRevenues < ActiveRecord::Migration[5.0]
  def change
    create_table :nobe_revenues do |t|
      t.references :user, foreign_key: true
      t.string :description
      t.integer :value_cents

      t.timestamps
    end
  end
end
