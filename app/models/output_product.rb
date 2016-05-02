class OutputProduct < ActiveRecord::Base

  belongs_to :product
  validates :product_id, presence: true
  validates :stock, presence: true, numericality: {greater_than: 0}
  before_validation :update_stock

  include PublicActivity::Model
  tracked only: [:products_low]

  def product=(value)
    @product=value
  end


  private
  def update_stock
    stock_product= product.stock
    subtraction = (stock_product-self.stock)
    if self.stock.nil?

    elsif subtraction<0
      self.errors.add(:base ,"No hay suficientes productos para dar de baja")
    elsif subtraction == 0
      product.update(stock: stock_product - self.stock,state: "sinCantidad")
    else

      product.update(stock: stock_product - self.stock)
    end
  end


end
