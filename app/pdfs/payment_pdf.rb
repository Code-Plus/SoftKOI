class PaymentPdf < Prawn::Document
  def initialize(sale_to_pdf,detail_sale,payment_to_pdf,user_do_payment,sale_id,sale_limit_date,sale_amount,sale_discount,sale_total_amount,pay_amount,sale_customer,sale_penalty)
    super(:background => "#{Rails.root}/app/assets/images/mrcadeagua.png")
    @sale_to_pdf = sale_to_pdf
    @detail_sale = detail_sale
    @payment_to_pdf = payment_to_pdf
    @user_do_payment = user_do_payment
    @sale_id =  sale_id
    @sale_limit_date = sale_limit_date
    @sale_amount = sale_amount
    @sale_discount =sale_discount
    @sale_total_amount =sale_total_amount
    @pay_amount =pay_amount
    @sale_customer = sale_customer
    @sale_penalty = sale_penalty
    header
    text_content
    table_content
    info_sale
    thanks
    footer
  end
  def header
    repeat :all do
			image "#{Rails.root}/app/assets/images/softkoi.png", :position => 230, :height =>70
		end
  end

  def text_content
    move_down 20
    font("Courier") do
      text "Comprobante de pago generado desde  SOFTKOI APP.", :align => :center
      move_down 20
      text "Este comprobante fue generado la fecha: #{Date.today}", :align =>:center
      text "Usuario encargado: #{@user_do_payment}", :align =>:center
      text "Codigo de venta: #{@sale_id}", :align =>:center
    end
  end

  def table_content
    move_down 10
      table sale_rows do
        row(0).font_style = :bold
        self.header = true
        self.row_colors = ['DDDDDD', 'FFFFFF']
        self.column_widths = [80,70,120,120]
        self.position = 60
      end
  end

  def sale_rows
    [['Producto','Cantidad', 'Precio unitario','Precio total']] +
		@detail_sale.map do |item|
			[item.product.name, item.quantity,item.product.price ,(item.product.price * item.quantity)]
		end
  end

  def info_sale
    move_down 20
    font("Courier") do
      column_box([70, cursor], :columns => 1, :width => bounds.width) do
        text "Subtotal: #{@sale_amount}                               Ha pagado: #{@pay_amount} "
        text "Descuento: #{@sale_total_amount * @sale_discount}                                 Debe: #{@sale_total_amount - @pay_amount}"
        text "Total de la venta: #{@sale_total_amount} "
        unless @sale_total_amount - @pay_amount == 0
        text "Fecha limite: #{@sale_limit_date}"
        end
        unless @sale_penalty == 0
          text "Multa: #{@sale_penalty}"
        end
      end
    end
  end

  def thanks
    move_down 20
		font("Courier") do
			text "#{@sale_customer} gracias por su compra, esperamos verlo pronto.", :align => :center
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
