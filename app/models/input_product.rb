class InputProduct < ActiveRecord::Base
  belongs_to :product

  validates :product_id, :stock, presence: true
  before_create :update_stock 


  #Getter de los valores de productos. Se esta usando para el stock
  def product=(value)
  	@product=value
  end

  private
  #Actualizar el stock del producto al que se le hace la entrada
  def update_stock
  	stock_product= product.stock
    product.update(stock: stock_product + self.stock)
  end



end
