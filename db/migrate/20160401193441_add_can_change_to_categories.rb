class AddCanChangeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :can_change, :boolean, :default =>true
  end
end
