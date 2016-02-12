class AddTypeProductsIdToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :type_products, index: true, foreign_key: true
  end
end
