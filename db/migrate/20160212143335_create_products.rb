class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :state
      t.integer :stock_min
      t.integer :stock
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
