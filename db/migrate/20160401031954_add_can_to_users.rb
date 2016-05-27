class AddCanToUsers < ActiveRecord::Migration
   def change
      add_column :users, :can_inventory, :boolean
      add_column :users, :can_sales, :boolean
      add_column :users, :can_changes, :boolean
      add_column :users, :can_consoles, :boolean
      add_column :users, :can_customers, :boolean
      add_column :users, :can_diary, :boolean
      add_column :users, :can_payments, :boolean
      
   end
end
