class Product < ActiveRecord::Base

   include AASM

   belongs_to :category
   has_many :output_products
   has_many :input_products
   has_many :reserves
   belongs_to :reserve_price
   before_validation :validate_category_change

   validates :name, presence: true
   validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
   validates :description, presence: true
   validates :stock_min, presence: true, numericality: {greater_than_or_equal_to: 0}
   validates :stock, numericality: {greater_than_or_equal_to: 0}
   validates :category_id, presence: true

   #Seleccionar productos disponibles
   scope :activos, -> { where(state: "disponible")}

   #Productos activos cuya cantidad sea mayor a cero.
   scope :activos_y_cantidad, ->{ activos.where("stock >= stock_min")}

   #Productos que esten activos y tengan cantidad en su stock
   scope :activos_con_cantidad, ->{activos.where("stock > 0")}

   #Productos de tipo y categoría consolas.
   scope :consolas, ->{joins(category: :type_product).select("products.id, products.name").where("type_product_id = 3")}

   aasm column: "state" do
      state :disponible, :initial => true
      state :noDisponible
      state :bajas

      #Eventos de movimiento o transiciones para los estados.
      event :disponible do
         transitions from: :noDisponible, to: :disponible
      end

      event :noDisponible do
         transitions from: :disponible, to: :noDisponible
      end

      event :bajas do
         transitions from: :disponible, to: :bajas
      end
   end

   private

   def validate_category_change
      category_change = category.can_change
      if category_change == false
         if self.can_change == true
            self.errors.add(:base ,"Esta categoria no permite cambios")
         end
      end
   end

end
