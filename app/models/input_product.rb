class InputProduct < ActiveRecord::Base

  belongs_to :product
  validates :product_id, presence: true
  validates :stock, presence: true, numericality: {greater_than: 0}
  before_create :update_stock

  include PublicActivity::Model
  tracked only: [:products_low]

  #Getter de los valores de productos para el stock
  def product=(value)
    @product=value
  end


  private
  #Actualizar el stock del producto al que se le hace la entrada
  def update_stock
    stock_product= product.stock
    unless self.stock.nil?
      product.update(stock: stock_product + self.stock, state: "disponible")
    end
  end

end
