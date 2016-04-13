class AddConsoleToReservePrice < ActiveRecord::Migration
  def change
     remove_column :reserve_prices, :console_id_id, :integer
     add_reference :reserve_prices, :console, index: true, foreign_key: true
  end
end
