class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :sale, index: true, foreign_key: true
      t.integer :quantity, :default => 1
      t.decimal :price, :precision => 8, :scale => 2
      t.decimal :total_price, :precision => 8, :scale => 2

      t.timestamps null: false
    end
  end
end
