class TypeProduct < ActiveRecord::Base

	#Gema para los estados.
	include AASM

	#Relaciones entre tablas.
	has_many :categories

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

	#Validaciones 
	validates :name, presence: true
	validates :description, presence: true, length: { in: 8..80 }

end