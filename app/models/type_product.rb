class TypeProduct < ActiveRecord::Base

	include AASM

	has_many :categories
	after_save :validar_estado
	attr_accessor :flash_notice
	validate :validar_estado
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true, length: { in: 8..80 }

	before_create :set_date
	before_update :set_updated_at

	#Seleccionar tipos de productos disponibles
	scope :activos, -> { where(state: "disponible")}

	#Tipo de productos con almenos 1 categoria asociadas
	scope :with_category, -> {joins(:categories)}


	aasm column: "state" do
		state :disponible, :initial => true
		state :noDisponible

		#Eventos de movimiento o transiciones para los estados.
		event :disponible do
			transitions from: :noDisponible, to: :disponible
		end

		event :noDisponible do
			transitions from: :disponible, to: :noDisponible
		end
	end

	private

	def validar_estado
		if self.state == "noDisponible"
			u = categories.select(:state ).where(state: 'disponible')
			u = u.count
			if u > 0
				puts "Hay Categorías habilitadas"
				self.flash_notice = "Hay categorías habilitadas asociadas a este tipo de producto."
				self.errors.add(:base, "Hay categorías habilitadas asociadas a este tipo de producto.")
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
end
