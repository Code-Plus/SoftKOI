class CouponPdf < Prawn::Document
	def initialize(detail_coupon,detail_sale, hash_products_to_coupon)
		@detail_coupon = detail_coupon
		@detail_sale = detail_sale
		@hash_products_to_coupon = hash_products_to_coupon
		super(:background => "#{Rails.root}/app/assets/images/mrcadeagua.png")
		header
		table_coupons_content
		new_page

		footer
	end

	def header
  	image "#{Rails.root}/app/assets/images/white_logo.png", :position => 230, :height =>70
  end

	def table_coupons_content
		move_down 10
		table coupon_rows do
			row(0).font_style = :bold
			self.header = true
			self.row_colors = ['DDDDDD', 'FFFFFF']
			self.column_widths = [80]
			self.position = 80
		end
	end

	def coupon_rows
		# [['Producto','Cantidad']] +
		# @detail_coupon.map do |dc|
		# 	[dc.sale.products.name, dc.quantity]
		# end
		[['Producto','Cantidad']] +
		@hash_products_to_coupon.map do |s|
			[s[0], s[1]]
		end
	end

	def new_page
		start_new_page #=> Starts new page keeping current values
		text "HOla pagina 2"
	end

	def table_sales_content
		move_down 10
		table sale_rows do
			row(0).font_style = :bold
			self.header = true
			self.row_colors = ['DDDDDD', 'FFFFFF']
			self.column_widths = [80]
			self.position = 80
		end
	end

	def sale_rows
		[['Producto','Cantidad', 'Precio']] +
		@detail_coupon.map do |s|
			[s.product.name, s.quantity, (s.product.price * s.quantity)]
		end
	end

	def footer
    bounding_box [bounds.left, bounds.bottom + 35], :width  => bounds.width  do
      font "Courier"
      stroke_horizontal_rule
      move_down(5)
      number_pages "<page> de <total>", { :start_count_at => 0, :page_filter => :all, :at => [bounds.right - 50, 0], :align => :right, :size => 12 }
      image "#{Rails.root}/app/assets/images/softkoifooter.png", :position => 250, :height =>25
    end
  end
end
