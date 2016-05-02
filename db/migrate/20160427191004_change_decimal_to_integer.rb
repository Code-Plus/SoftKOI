class ChangeDecimalToInteger < ActiveRecord::Migration
  def change
    change_column :items, :price, :integer
    change_column :items, :total_price, :integer
  end
end
