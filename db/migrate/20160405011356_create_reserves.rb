class CreateReserves < ActiveRecord::Migration
  def change
    create_table :reserves do |t|
      t.string :customer
      t.integer :product_id
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :state
      t.integer :price_reserve_id

      t.timestamps null: false
    end
  end
end
