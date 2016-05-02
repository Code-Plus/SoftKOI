class Item < ActiveRecord::Base

  belongs_to :product
  belongs_to :sale

  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :total_price, presence: true, numericality: { only_integer: true }
  before_validation :actualizar_stock

  private

  def actualizar_stock
  	stock_product = product.stock
    if self.quantity.nil?

      elsif (stock_product-self.quantity)<0
         self.errors.add(:base ,"No hay suficientes productos para vender")
      else
         product.update(stock: stock_product - self.quantity)
      end
  end
end
