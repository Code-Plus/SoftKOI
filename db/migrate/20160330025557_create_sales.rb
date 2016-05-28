class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :state
      t.decimal :amount, :precision => 8, :scale => 2
      t.decimal :total_amount, :precision => 8, :scale => 2
      t.decimal :discount, :precision => 8, :scale => 2
      t.decimal :remaining
      t.date :limit_date
      t.text :comment
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
