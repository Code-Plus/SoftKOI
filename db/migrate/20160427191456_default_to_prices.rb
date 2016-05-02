class DefaultToPrices < ActiveRecord::Migration
  def change
     change_column :items, :price, :integer, :default => 0
     change_column :items, :total_price, :integer, :default => 0
  end
end
