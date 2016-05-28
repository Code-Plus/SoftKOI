class RemoveRemainingSales < ActiveRecord::Migration
  def change
     remove_column :sales, :remaining, :decimal
  end
end
