class Category < ActiveRecord::Base

	include AASM
	
	belongs_to :type_product
	has_many :products

	validates :name, :type_product_id, :state, presence: true
	validates :description, presence: true, length: { in: 8..80 }

	#Le designamos a la columna "state" unos estados
	aasm column: "state" do
		
		state :disponible, :initial => true
		state :noDisponible


		event :disponible do
			#La transicion de este estado es a NoDisponible
			transitions from: :noDisponible, to: :disponible
		end

		event :noDisponible do
			#La transicion de este estado es a Disponible
			transitions from: :disponible, to: :noDisponible
		end
	end

end
