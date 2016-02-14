class Category < ActiveRecord::Base
	#Inclumos la gema AASM para los estados
	include AASM
	
	#Aca iran las conexiones entre tablas
	belongs_to :type_product
	has_many :products

	#Le designamos a la columna "state" unos estados
	aasm column: "state" do
		#Creamos un estado disponible que va a ser el default
		state :Disponible, :initial => true
		#Creamos un estado NoDisponible
		state :NoDisponible

		#Cremos un evento de movimiento para el estado Diponible
		event :Disponible do
			#La transicion de este estado es a NoDisponible
			transitions from: :NoDisponible, to: :Disponible
		end

		#Cremos un evento de movimiento para el estado NoDiponible
		event :NoDisponible do
			#La transicion de este estado es a Disponible
			transitions from: :Disponible, to: :NoDisponible
		end
	end

	#Aca van las validaciones
	validates :name, presence: true
	validates :description, presence: true, length: { in: 8..80 }
	validates :state, presence: true
	validates :type_product_id, presence: true

end
