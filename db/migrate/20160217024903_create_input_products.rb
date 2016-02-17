class CreateInputProducts < ActiveRecord::Migration
  def change
    create_table :input_products do |t|
      t.integer :stock
      t.integer :stock_min
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
