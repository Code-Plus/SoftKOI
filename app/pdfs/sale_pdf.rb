class SalePdf < Prawn::Document
	def initialize(sale)
		super(:background  => "#{Rails.root}/app/assets/images/softkoi.png")
		@sale = sale
		hello
	end

	def hello
		text "Hola soy una venta"
	end
end