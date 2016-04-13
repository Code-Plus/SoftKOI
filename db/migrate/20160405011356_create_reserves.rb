class CreateReserves < ActiveRecord::Migration
  def change
    create_table :reserves do |t|
      t.string :customer
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :state
      t.integer :reserve_price_id

      t.timestamps null: false
    end
  end
end
