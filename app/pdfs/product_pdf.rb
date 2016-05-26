class ProductPdf < Prawn::Document
  def initialize(products_for_pdf,date_from,date_to)
    super(:background => "#{Rails.root}/app/assets/images/mrcadeagua.png")
    @products_for_pdf = products_for_pdf
    @date_from = date_from
    @date_to = date_to
    header
    text_content
    table_content
    footer
  end
  def header
  	image "#{Rails.root}/app/assets/images/softkoi.png", :position => 230, :height =>70
  end

  def text_content
    move_down 20
    font("Courier") do
      text "Reporte de registros de productos generados desde SOFTKOI APP.", :align => :center
      move_down 20
      text "Este reporte fue generado el día: #{Date.today}", :align =>:center
      move_down 20
        text "Productos registrados desde #{@date_from} hasta  #{@date_to}.", :align => :center
    end
  end

  def table_content
    move_down 10
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [60]
      self.position = 80
    end
  end

  def product_rows
    [['#', 'Producto', 'Precio', 'Cantidad actual', 'Cantidad Mínima']] +
      @products_for_pdf.map do |product|
      [product.id,product.name,product.price,product.stock, product.stock_min]
    end
  end

  def footer
    bounding_box [bounds.left, bounds.bottom + 35], :width  => bounds.width  do
      font "Courier"
      stroke_horizontal_rule
      move_down(10)
      number_pages "<page> de <total>", { :start_count_at => 0, :page_filter => :all, :at => [bounds.right - 50, 0], :align => :right, :size => 12 }
      move_down(5)
      image "#{Rails.root}/app/assets/images/softkoifooter.png", :position => 250, :height =>25
    end
  end
end
