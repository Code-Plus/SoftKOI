class InputProduct < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :stock, presence: true
  before_create :update_stock
  before_create :datos


  def product=(value)
  	@product=value
  end


#####################
  def datos
    @id= product.id
    @price = product.price
    @name = product.name
  end

#######################
  private
  #Metodo para actualizar el stock del producto al que se le hace la entrada
  def update_stock
  	stock_product= product.stock
    product.update(stock: stock_product + self.stock)
  end

end
