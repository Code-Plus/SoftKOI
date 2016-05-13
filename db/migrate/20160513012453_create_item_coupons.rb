class CreateItemCoupons < ActiveRecord::Migration
  def change
    create_table :item_coupons do |t|
      t.references :sale, index: true, foreign_key: true
      t.references :coupon, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
