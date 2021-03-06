class OutputProduct < ActiveRecord::Base

  belongs_to :product
  validates :product_id, presence: true
  validates :stock, presence: true, numericality: {greater_than: 0}
  before_validation :update_stock #, :validate_state_product
  before_create :set_date
  before_update :set_updated_at



  def product=(value)
    @product=value
  end

  #Salidas registradas en la ultima semana
  scope :registered_last_week, ->{group("output_products.created_at::date").where("created_at >= ? ", 1.week.ago ).count}

  private
  def update_stock
    stock_product= product.stock
    subtraction = (stock_product-self.stock)
    if self.stock.nil?
    elsif subtraction<0
      self.errors.add(:base ,"No hay suficientes productos para dar de baja, la cantidad actual es #{stock_product}")
    elsif subtraction == 0
      product.update(stock: stock_product - self.stock,state: "sinCantidad")
    else
      product.update(stock: stock_product - self.stock)
    end
  end

  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end
  #
  # def validate_state_product
  #   product_state = product.state
  #   if product_state == "noDisponible"
  #     self.errors.add(:base ,"No se permiten salidas de este producto, su estado es 'no disponible' ")
  #   end
  # end

end
