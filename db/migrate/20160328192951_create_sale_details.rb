class CreateSaleDetails < ActiveRecord::Migration
  def change
    create_table :sale_details do |t|
      t.integer :discount
      t.integer :price
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
