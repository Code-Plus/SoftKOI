class CreateTypeProducts < ActiveRecord::Migration
  def change
    create_table :type_products do |t|
      t.string :name
      t.text :description
      t.string :state

      t.timestamps null: false
    end
  end
end
