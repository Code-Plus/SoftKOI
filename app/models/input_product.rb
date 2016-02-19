class InputProduct < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :stock, presence: true

  after_create :update_stock

  #Tengo un error en este metodo
  def update_stock
    @product.update(stock: @product.stock + @input_product.stock)
  end
end
