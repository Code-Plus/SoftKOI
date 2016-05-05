class ProductPdf < Prawn::Document
  def initialize(products_for_pdf,date_from,date_to)
    super()
    @products_for_pdf = products_for_pdf
    @date_from = date_from
    @date_to = date_to
    header
    text_content
    table_content
    footer
  end
  def header
  	image "#{Rails.root}/app/assets/images/Perrito_p.png", :position => 160
  end

  def text_content
    move_down 20
    font("Courier") do
      text "Productos registrados desde #{@date_from} hasta el #{@date_to}.", :align => :center
    end
  end

  def table_content
    move_down 40
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [40]
    end
  end

  def product_rows
    [['#', 'Producto', 'Precio', 'Cantidad actual', 'Cantidad Minima']] +
      @products_for_pdf.map do |product|
      [product.id,product.name,product.price,product.stock, product.stock_min]
    end
  end

  def footer

  end
end
