class Product < ActiveRecord::Base


  include AASM
  belongs_to :category
  has_many :output_products
  has_many :input_products

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :stock_min, presence: true
  validates :state, presence: true
  validates :category_id, presence: true

  #El scope verifica y nos trae los productos que tengan estado disponible
  scope :activos, ->{ where(state: "disponible")}

  #El scope obtiene los precios de los registros de la tabla product cuyo name sea Pantalon
  scope :precios, -> { where(:name => 'Pantalon').select(:id,:price)}

  #Productos activos cuya cantidad sea mayor a cero.
  scope :activos_y_cantidad, ->{ activos.where("stock > 0")}

  #Productos activos cuya cantidad sea menor al stock mínimo.
  scope :activos_cantidad_stock_min, ->{ activos_y_cantidad.where("stock < stock_min")}

  ######
  #scope :by_name, -> (name) { where(name: name) }
  #scope :prices, -> { select(:prices) }
  #####


  aasm column: "state" do

    state :disponible, :initial => true

    state :noDisponible

    state :deBaja

    event :disponible do
      transitions from: :noDisponible, to: :diponible
    end
    event :noDisponible do
      transitions from: :disponible, to: :noDisponible
    end

    event :deBaja do
      transitions from: :disponible, to: :deBaja
    end

  end


end
