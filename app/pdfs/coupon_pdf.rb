class CouponPdf < Prawn::Document
	def initialize(detail_coupon,detail_sale, hash_products_to_coupon,coupon_to_pdf,sale_to_pdf,coupon_amount)
		@detail_coupon = detail_coupon
		@detail_sale = detail_sale
		@hash_products_to_coupon = hash_products_to_coupon
		@coupon_to_pdf =coupon_to_pdf
		@sale_to_pdf =sale_to_pdf
		@coupon_amount = coupon_amount
		super(:background => "#{Rails.root}/app/assets/images/mrcadeagua.png")
		header
		text_coupon
		table_coupons_content
		text_info_coupon
		text_sale
		table_sales_content
		text_thanks
		footer
	end

	def header
			image "#{Rails.root}/app/assets/images/softkoi.png", :position => 230, :height =>70
  end

	def text_coupon
		move_down 20
		font("Courier") do
			text "Comprobante de cambio generado desde  SOFTKOI APP.", :align => :center
      move_down 20
      text "Este comprobante fue generado la fecha: #{Date.today}", :align =>:center
			move_down 20
			text "Estos son los productos que cambio.", :align =>:center
		end
	end
	def table_coupons_content
		move_down 10
		table coupon_rows do
			row(0).font_style = :bold
			self.header = true
			self.row_colors = ['DDDDDD', 'FFFFFF']
			self.column_widths = [80]
			self.position = 180
		end
	end

	def text_info_coupon
		move_down 30
		font("Courier") do
			text "Este bono tiene un valor de #{@coupon_amount} y le servira para su proxima compra, su codigo es:#{ @coupon_to_pdf}", :align => :center
		end
	end

	def coupon_rows
		[['Producto','Cantidad']] +
		@hash_products_to_coupon.map do |s|
			[s[0], s[1]]
		end
	end

	def text_sale
		move_down 20
		font("Courier") do
			text "Se ha generado una nueva venta con el codigo: #{@sale_to_pdf}", :align => :center
		end
	end

	def table_sales_content
		move_down 20
		table sale_rows do
			row(0).font_style = :bold
			self.header = true
			self.row_colors = ['DDDDDD', 'FFFFFF']
			self.column_widths = [80]
			self.position = 80
		end
	end

	def sale_rows
		[['Producto','Cantidad', 'Precio unitario','Precio total']] +
		@detail_sale.map do |s|
			[s.product.name, s.quantity,s.product.price ,(s.product.price * s.quantity)]
		end
	end

	def text_thanks
		move_down 20
		font("Courier") do
			text "Gracias por su compra, esperamos verlo pronto.", :align => :center
		end
	end

	def footer
		bounding_box [bounds.left, bounds.bottom + 35], :width  => bounds.width  do
				font "Courier"
				move_down(10)
				number_pages "<page> de <total>", { :start_count_at => 0, :page_filter => :all, :at => [bounds.right - 50, 0], :align => :right, :size => 12 }
			repeat :all do
				stroke_horizontal_rule
				move_down(5)
				image "#{Rails.root}/app/assets/images/softkoifooter.png", :position => 250, :height =>25,  :page_filter => :all
			end
		end
  end
end
