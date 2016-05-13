class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :amount

      t.timestamps null: false
    end
  end
end
