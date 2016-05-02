class RemoveConsoleReservation < ActiveRecord::Migration
  def change
    remove_column :reservations, :console_id, :integer
  end
end
