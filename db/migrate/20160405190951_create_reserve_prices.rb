class CreateReservePrices < ActiveRecord::Migration
  def change
    create_table :reserve_prices do |t|
      t.integer :value
      t.integer :time
      t.references :product, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
