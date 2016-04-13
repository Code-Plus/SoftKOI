class CreateConsoles < ActiveRecord::Migration
  def change
    create_table :consoles do |t|
      t.string :name
      t.text :description
      t.string :serial
      t.string :state

      t.timestamps null: false
    end
  end
end
