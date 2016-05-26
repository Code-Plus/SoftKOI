class Product < ActiveRecord::Base
    include PublicActivity::Model
  belongs_to :category
  has_many :output_products
  has_many :input_products
  has_many :items

  before_create :set_date
  before_update :set_updated_at

  before_validation :validate_category_change, :validate_category_state
  after_update :change_state_to_sinCantidad

  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :description, presence: true
  validates :stock_min, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :stock, numericality: {greater_than_or_equal_to: 0}
  validates :category_id, presence: true


  include AASM

  #Productos disponibles
  scope :activos, -> { where(state: "disponible")}

  #Productos que esten activos y tengan cantidad en su stock
  scope :active_stock_min, ->{ activos.where("stock >= stock_min")}

  #Productos activos cuya cantidad sea mayor a cero.
  scope :active_quantity, ->{activos.where("stock > 0")}

  #Productos que se crearon en la fecha actual
  scope :creados_hoy, ->{where("created_at.strftime('%Y-%d-%m') => Time.now.strftime('%Y-%d-%m')")}

  #Productos registrados en la ultima semana
  scope :registered_last_week, ->{group("products.created_at::date").where("created_at >= ? ", 1.week.ago ).count}

  #Productos que se puedan cambiar
  scope :product_can_change, -> {where(can_change: true)}


  def self.creados_hoy(current_time)
    product_created = Product.select("products.id, products.created_at")
    created = nil

    product_created.each do |t|
      if t.created_at.strftime("%F") == current_time
        created = t.created_at.strftime("%F")
      end
    end

    products_finallly = Product.where("created_at LIKE '#{created}%'").select("products.id, products.name, products.description, products.category_id, products.stock_min, products.stock, products.price")
    puts products_finallly.pluck(:id)
    return products_finallly
  end

  aasm column: "state" do
    state :disponible, :initial => true
    state :noDisponible
    state :sinCantidad

    #Eventos de movimiento o transiciones para los estados.
    event :disponible do
      transitions from: :noDisponible, to: :disponible
    end

    event :noDisponible do
      transitions from: :disponible, to: :noDisponible
      transitions from: :sinCantidad, to: :noDisponible
    end

    event :sinCantidad do
      transitions from: :disponible, to: :sinCantidad
    end
  end

=begin
  def reports(product,current_time)
    product.each do |p|
      if p.create_at.strftime("%Y-%d-%m") == Time.now.strftime("%Y-%d-%m")
      end
    end
  end
=end

  private

  def validate_category_change
    category_change = category.can_change
    if category_change == false
      if self.can_change == true
        self.errors.add(:base ,"Esta Categoría no permite cambios")
      end
    end
  end

  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def change_state_to_sinCantidad
    if self.state == "noDisponible" || self.state == "disponible"
      if self.stock == 0
        self.update(state: "sinCantidad")
      end
    end
  end

  def validate_category_state
    category_state = category.state
    if category_state == "noDisponible"
      self.errors.add(:base ,"No se puede habilitar el producto, la categoria no esta disponible")
    end
  end


end
