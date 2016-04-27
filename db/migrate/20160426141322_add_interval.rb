class AddInterval < ActiveRecord::Migration
  def change
    add_column :reservations, :interval, :integer
  end
end
