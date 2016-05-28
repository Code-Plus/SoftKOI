class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :document
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :cellphone
      t.date :birthday
      t.string :email
      t.string :state
      t.references :type_document, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
