class OutputProduct < ActiveRecord::Base
  
  belongs_to :product

  validates :product_id, :stock, presence: true
  before_create :update_stock

  def product=(value)
    @product=value
  end

  private

  def update_stock
  	stock_product= product.stock
    product.update(stock: stock_product - self.stock)
  end

end
