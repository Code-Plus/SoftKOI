class Category < ActiveRecord::Base

	include AASM

	belongs_to :type_product
	has_many :products


	#Inhabilitar productos si la Categoría se inhabilita
	after_save do
		if self.state == "noDisponible"
			#Actualizar productos con la Categoría asociada a estado noDisponible
			products.update_all state: "noDisponible"
		end
	end

	#Actualizar a "false" el "can_change" de los productos asociados
	after_save do
		if self.can_change == false
			products.update_all can_change: false
		end
	end

	validates :name, :type_product_id, :state, presence: true
	validates :description, presence: true, length: { in: 8..80 }


	#Seleccionar Categorías disponibles
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
