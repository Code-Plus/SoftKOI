class InputProduct < ActiveRecord::Base

  belongs_to :product
  validates :product_id, presence: true
  validates :stock, presence: true, numericality: {greater_than: 0}
  before_create :update_stock, :set_date
  before_update :set_updated_at

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

  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.update_at = Time.now.in_time_zone("Bogota")
  end

end
