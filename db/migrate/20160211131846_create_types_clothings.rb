class CreateTypesClothings < ActiveRecord::Migration
  def change
    create_table :types_clothings do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
