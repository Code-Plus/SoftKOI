class RemovePenaltyPayment < ActiveRecord::Migration
  def change
    remove_column :payments, :penalty, :integer
  end
end
