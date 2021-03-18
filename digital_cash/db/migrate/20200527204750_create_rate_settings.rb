class CreateRateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :rate_settings do |t|
      t.integer :day_of_week
      t.integer :rate_cents
      t.integer :alternative_rate_cents
      t.time :initial_time
      t.time :end_time

      t.timestamps
    end
  end
end
