class AddCanChangeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :can_change, :boolean, :default =>true
  end
end
