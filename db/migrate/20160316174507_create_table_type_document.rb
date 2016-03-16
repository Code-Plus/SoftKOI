class CreateTableTypeDocument < ActiveRecord::Migration
  def change
    create_table :type_documents do |t|
    	t.string :description, null: false
    end
  end
end
