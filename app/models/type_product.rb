class TypeProduct < ActiveRecord::Base

	include AASM

	has_many :categories

	#Validaciones
	validates :name, presence: true
	validates :description, presence: true, length: { in: 8..80 }

	#Muestra los tipos de producto con estado "disponible"
	scope :activos, -> { where(state: "disponible")}

	aasm column: "state" do
		#Estado por default
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
end
