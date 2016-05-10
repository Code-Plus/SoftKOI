class OutputProductsController < ApplicationController

  load_and_authorize_resource
  after_action :products_low, only:[:create]

  def index
    @output_products = OutputProduct.all
    @search = Report.new(params[:search])
  end


  def new
    #Obtener el producto que se selecciono para la baja
    @productx = Product.find(params[:product_id])
    @output_product = @productx.output_products.build
    @product = Product.activos
  end

  def generate_pdf
    @search = Report.new(params[:search])
    @outputproducts_to_pdf = @search.search_date_outputproducts
    @date_from = @search.date_from.to_date
    @date_to = @search.date_to.to_date
    respond_to do |format|
      format.html
      format.pdf do
        pdf=OutputproductPdf.new(@outputproducts_to_pdf,@date_from,@date_to)
        send_data pdf.render, filename: 'salida_productos.pdf',disposition: "inline",type: 'application/pdf'
      end
    end
  end


  def create
    @output_product = Product.new
    @output_product = OutputProduct.new(output_product_params)
    @output_product.product = params[:stock]
    respond_to do |format|
      if @output_product.save
        format.html { redirect_to products_path, notice: 'La salida se ha registrado correctamente' }
        format.json { render :index, status: :created, location: @output_product }
      else
        format.html { render :new }
        format.json { render json: @output_product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def products_low
    if @output_product.product.stock <= @output_product.product.stock_min
      @output_product.product.create_activity key: 'se esta agotando', read_at: nil
    end
  end

  private

  def set_output_product
    @output_product = OutputProduct.find(params[:id])
  end

  def output_product_params
    params.require(:output_product).permit(:stock, :product_id)
  end
end
