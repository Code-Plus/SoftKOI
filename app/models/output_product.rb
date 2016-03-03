class OutputProduct < ActiveRecord::Base
  
  belongs_to :product
  validates :product_id, :stock, presence: true
  before_validation :update_stock


  def product=(value)
    @product=value
  end


  private
  def update_stock
  	stock_product= product.stock
    stock_out=self.stock
    stock_rest = stock_product - self.stock
    
    if stock_rest>=0
      product.update(stock: stock_product - stock_out)
    else  
      puts "No hay suficientes productos"
    end
  end




end
