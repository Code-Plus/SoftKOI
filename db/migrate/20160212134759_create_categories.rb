class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :state
      t.references :type_product, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
