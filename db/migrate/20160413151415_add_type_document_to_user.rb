class AddTypeDocumentToUser < ActiveRecord::Migration
  def change
    add_reference :users, :type_document, index: true, foreign_key: true
  end
end
