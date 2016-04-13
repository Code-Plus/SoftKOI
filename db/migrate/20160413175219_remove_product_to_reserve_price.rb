class RemoveProductToReservePrice < ActiveRecord::Migration
  def change
     remove_column :reserve_prices, :product_id, :index
     add_reference :reserve_prices, :console_id, index: true, foreign_key: true
  end
end
