class AddColumNameEvents < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
  end
end
