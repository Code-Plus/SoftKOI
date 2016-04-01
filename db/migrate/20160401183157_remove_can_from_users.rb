class RemoveCanFromUsers < ActiveRecord::Migration
  def change
     remove_column :users, :can_diary, :boolean
     remove_column :users, :can_payments, :boolean
  end
end
