class InputProduct < ActiveRecord::Base

  belongs_to :product
  validates :product_id, presence: true
  validates :stock, presence: true, numericality: {greater_than: 0}
  before_create :update_stock, :set_date
  before_validation :validate_state_product
  before_update :set_updated_at

  #Getter de los valores de productos para el stock
  def product=(value)
    @product=value
  end

  #Entradas registradas en la ultima semana
  scope :registered_last_week, ->{group("input_products.created_at::date").where("created_at >= ? ", 1.week.ago ).count}


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
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def validate_state_product
    product_state = product.state
    if product_state == "noDisponible"
      self.errors.add(:base ,"No se permiten entradas a  este producto, su estado es 'no disponible' ")
    end
  end

end
