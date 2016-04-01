class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :sale

  validates :product_id, presence: true
  validates :sale_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :total_price, presence: true, numericality: { only_integer: true }
  before_validation :actualizar_stock

  private

  def actualizar_stock
  	stock = product.stock
  end
end
