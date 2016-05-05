class ReportsController < ApplicationController
  def index
      @search = Report.new(params[:search])
  end

  def report_product
    @search = Report.new(params[:search])
    @products_to_pdf = @search.search_date_products
    respond_to do |format|
      format.html
      format.pdf do
        pdf=ProductPdf.new(@products_to_pdf)
        send_data pdf.render, filename: 'productos.pdf',disposition: "inline",type: 'application/pdf'
      end
    end
  end
end
