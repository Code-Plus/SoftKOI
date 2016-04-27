class ChangeSales < ActiveRecord::Migration
  def change
     change_column :sales, :amount, :integer, :default => 0
     change_column :sales, :total_amount, :integer, :default => 0
     change_column :sales, :discount, :integer, :default => 0
     change_column :sales, :limit_date, :date, :default => Time.now
  end
end
