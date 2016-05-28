class RemoveIntervalReservation < ActiveRecord::Migration
  def change
    remove_column :reservations, :interval
  end
end
