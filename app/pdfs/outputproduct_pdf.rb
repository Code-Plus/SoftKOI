class OutputproductPdf < Prawn::Document
  def initialize(outputproducts_for_pdf,date_from,date_to)
    super(:background => "#{Rails.root}/app/assets/images/mrcadeagua.png")
    @outputproducts_for_pdf = outputproducts_for_pdf
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
      text "Reporte de baja de productos generados desde SOFTKOI APP.", :align => :center
      move_down 20
      text "Este reporte fue generado la fecha: #{Date.today}", :align =>:center
      move_down 20
        text "Productos dados de baja desde #{@date_from} hasta el #{@date_to}.", :align => :center
    end
  end

  def table_content
    move_down 10
    table outputproduct_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [110,70]
      self.position = 80
    end
  end

  def outputproduct_rows
    [['Cantidad de baja', 'Producto', 'Fecha']] +
      @outputproducts_for_pdf.map do |outputproduct|
      [outputproduct.stock, outputproduct.product.name, outputproduct.created_at.to_date]
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
