class CreateTypesConsoles < ActiveRecord::Migration
  def change
    create_table :types_consoles do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
