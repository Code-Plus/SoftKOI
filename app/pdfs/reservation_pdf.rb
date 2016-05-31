class ReservationPdf < Prawn::Document
  def initialize(reservations_to_pdf,date_from,date_to)
    super(:background => "#{Rails.root}/app/assets/images/mrcadeagua.png")
    @reservations_to_pdf = reservations_to_pdf
    @date_from = date_from
    @date_to = date_to
    header
    text_content
    table_content
    footer
  end
  def header
    repeat :all do
			image "#{Rails.root}/app/assets/images/softkoi.png", :position => 230, :height =>70
		end
  end

  def text_content
    repeat :all do
      move_down 20
      font("Courier") do
        text "Reporte de registros de reservas generados desde SOFTKOI APP.", :align => :center
        move_down 20
        text "Este reporte fue generado el día: #{Date.today}", :align =>:center
        move_down 20
          text "Reservas registrados desde #{@date_from} hasta  #{@date_to}.", :align => :center
      end
    end
  end

  def table_content
    bounding_box([10, 540], :width => 540, :height => 500) do
      table reservation_rows do
        row(0).font_style = :bold
        self.header = true
        self.row_colors = ['DDDDDD', 'FFFFFF']
        self.column_widths = [80,60]
        self.position = 100
      end
    end
  end

  def reservation_rows
    [['Consola', 'Tiempo', 'Precio', 'Cliente' ,'Dia']] +
      @reservations_to_pdf.map do |reservation|
      [reservation.reserve_price.console.name, reservation.reserve_price.time, reservation.reserve_price.value, reservation.customer, reservation.created_at.strftime('%F') ]
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
