class ChangePaymentAttr < ActiveRecord::Migration
  def change
  	change_column :payments,:amount, :integer, :default => 0
  	change_column :payments,:penalty, :integer, :default => 0
  end
end
