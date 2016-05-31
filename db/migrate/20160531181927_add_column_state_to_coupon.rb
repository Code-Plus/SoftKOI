class AddColumnStateToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :state, :string
  end
end
