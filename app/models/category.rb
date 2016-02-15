class Category < ActiveRecord::Base
	#Inclumos la gema AASM para los estados
	include AASM
	
	#Aca iran las conexiones entre tablas
	belongs_to :type_product
	has_many :products

	#Le designamos a la columna "state" unos estados
	aasm column: "state" do
		#Creamos un estado disponible que va a ser el default
		state :disponible, :initial => true
		#Creamos un estado NoDisponible
		state :noDisponible

		#Cremos un evento de movimiento para el estado Diponible
		event :disponible do
			#La transicion de este estado es a NoDisponible
			transitions from: :noDisponible, to: :disponible
		end

		#Cremos un evento de movimiento para el estado NoDiponible
		event :noDisponible do
			#La transicion de este estado es a Disponible
			transitions from: :disponible, to: :noDisponible
		end
	end

	#Aca van las validaciones
	validates :name, presence: true
	validates :description, presence: true, length: { in: 8..80 }
	validates :state, presence: true
	validates :type_product_id, presence: true

end
