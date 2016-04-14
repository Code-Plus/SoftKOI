class AddConsoleIdToReserve < ActiveRecord::Migration
  def change
    add_reference :reserves, :console, index: true, foreign_key: true
  end
end
