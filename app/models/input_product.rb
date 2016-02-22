class InputProduct < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :stock, presence: true

  before_create :update_stock



  #Tengo un error en este metodo
  def update_stock
    @products.update(stock_min: @products.stock + self.stock)
  end
end
