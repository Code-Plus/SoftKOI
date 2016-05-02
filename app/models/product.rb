class Product < ActiveRecord::Base

  belongs_to :category
  has_many :output_products
  has_many :input_products
  has_many :items

  before_validation :validate_category_change
  after_update do
    if self.state == "noDisponible" || self.state == "disponible"
      if self.stock == 0
        self.update(state: "sinCantidad")
      end
    end
  end


  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :description, presence: true
  validates :stock_min, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :stock, numericality: {greater_than_or_equal_to: 0}
  validates :category_id, presence: true


   include AASM
   include PublicActivity::Model
   tracked only: [:products_low]

   #Productos disponibles
   scope :activos, -> { where(state: "disponible")}

   #Productos activos cuya cantidad sea mayor a cero.
   scope :activos_y_cantidad, ->{ activos.where("stock >= stock_min")}

   #Productos que esten activos y tengan cantidad en su stock
   scope :activos_con_cantidad, ->{activos.where("stock > 0")}

   #Productos que se crearon en la fecha actual
   scope :creados_hoy, ->{where("created_at.strftime('%Y-%d-%m') => Time.now.strftime('%Y-%d-%m')")}

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

end
