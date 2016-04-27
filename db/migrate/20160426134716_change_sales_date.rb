class ChangeSalesDate < ActiveRecord::Migration
  def change
    change_column :sales, :limit_date, :date
  end
end
