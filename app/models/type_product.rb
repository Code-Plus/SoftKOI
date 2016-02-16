class TypeProduct < ActiveRecord::Base
<<<<<<< HEAD

	#Gema para los estados.
	include AASM

	#Relaciones entre tablas.
	has_many :categories

	aasm column: "state" do 
		#Estado por default
		state :Disponible, :initial => true
		state :NoDisponible

		#Eventos de movimiento o transiciones para los estados.
		event :Disponible do
			transitions from: :NoDisponible, to: :Disponible
		end

		event :NoDisponible do
			transitions from: :Disponible, to: :NoDisponible
		end
	end

	#Validaciones 
	validates :name, presence: true
	validates :description, presence: true, length: { in: 8..80 }

=======
	has_many :categories
>>>>>>> 884edbdb2cbe89dfc79e9988aee4c8c0faca1520
end
