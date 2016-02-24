class InputProduct < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :stock, presence: true
  before_create :update_stock



  def product=(value)
  	@product=value
  end

  private
  #Metodo para actualizar el stock del producto al que se le hace la entrada
  def update_stock
  	stock_product= product.stock
    product.update(stock: stock_product + self.stock)
  end

  


end
