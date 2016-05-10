class InputProductsController < ApplicationController

  load_and_authorize_resource
  after_action :products_low, only:[:create]

  def index
    @input_products = InputProduct.all
    @search = Report.new(params[:search])
  end

  def generate_pdf
    @search = Report.new(params[:search])
    @inputproducts_to_pdf = @search.search_date_inputproducts
    @date_from = @search.date_from.to_date
    @date_to = @search.date_to.to_date
    respond_to do |format|
      format.html
      format.pdf do
        pdf=InputproductPdf.new(@inputproducts_to_pdf,@date_from,@date_to)
        send_data pdf.render, filename: 'entrada_productos.pdf',disposition: "inline",type: 'application/pdf'
      end
    end
  end


  def new
    #Obtener el producto que se selecciono para la entrada
    @productx = Product.find(params[:product_id])
    @input_product = @productx.input_products.build

    #Traer todos los productos con estado disponible
    @product=Product.activos
  end


  def create
    @input_product = Product.new
    @input_product = InputProduct.new(input_product_params)
    @input_product.product = params[:stock]

    respond_to do |format|
      if @input_product.save
        format.html { redirect_to products_path, notice: 'La entrada se ha registrado correctamente' }
        format.json { render :index, status: :created, location: @input_product }
      else
        format.html { render :new }
        format.json { render json: @input_product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def products_low
    if @input_product.product.stock <= @input_product.product.stock_min
      @input_product.product.create_activity key: 'se esta agotando', read_at: nil
    end
  end


  private

  def input_product_params
    params.require(:input_product).permit(:stock, :product_id)
  end

end
