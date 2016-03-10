class TypeProduct < ActiveRecord::Base

	include AASM

	has_many :categories
 	after_save :validar_estado

	validate :validar_estado
	validates :name, presence: true
	validates :description, presence: true, length: { in: 8..80 }

	#Seleccionar tipos de productos disponibles
	scope :activos, -> { where(state: "disponible")}

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
			if u != nil
				puts "Hay categorias habilitadas"
				self.errors.add(:state,"--->Hay categorias habilitadas")
			end
		end
	end


end
