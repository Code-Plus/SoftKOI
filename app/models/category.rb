class Category < ActiveRecord::Base

	include AASM

	belongs_to :type_product
	has_many :products


	#Inhabilitar productos si la categoria se inhabilita
	after_save do
		if self.state == "noDisponible"
			#Actualizar productos con la categoria asociada a estado noDisponible
			products.update_all state: "noDisponible"
		end
	end

	validates :name, :type_product_id, :state, presence: true
	validates :description, presence: true, length: { in: 8..80 }


	#Seleccionar categorias disponibles
	scope :activos, -> { where(state: "disponible")}


	aasm column: "state" do

		state :disponible, :initial => true
		state :noDisponible


		event :disponible do
			transitions from: :noDisponible, to: :disponible
		end

		event :noDisponible do
			transitions from: :disponible, to: :noDisponible
		end
	end


end
