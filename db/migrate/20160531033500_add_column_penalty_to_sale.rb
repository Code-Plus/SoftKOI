class AddColumnPenaltyToSale < ActiveRecord::Migration
  def change
    add_column :sales, :penalty, :integer , :default => 0
  end
end
