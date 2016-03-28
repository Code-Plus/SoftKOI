class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :state
      t.datetime :final_date
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
