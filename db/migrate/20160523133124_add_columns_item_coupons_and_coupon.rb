class AddColumnsItemCouponsAndCoupon < ActiveRecord::Migration
  def change
    add_reference :coupons, :user, index: true, foreign_key: true
    add_column :item_coupons, :quantity, :integer
    add_reference :events, :user, index: true, foreign_key: true
  end
end
