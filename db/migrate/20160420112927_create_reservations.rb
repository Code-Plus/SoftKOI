class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :state
      t.string :customer
      t.references :console, index: true, foreign_key: true
      t.references :reserve_price, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
