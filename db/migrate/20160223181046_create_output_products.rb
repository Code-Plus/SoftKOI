class CreateOutputProducts < ActiveRecord::Migration
  def change
    create_table :output_products do |t|
      t.integer :stock, :default => 0 
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
