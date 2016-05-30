class ChangeDiscount < ActiveRecord::Migration
  def change
  	change_column :sales, :discount, :decimal, :precision => 8, :scale => 2, :default => nil
  end
end
