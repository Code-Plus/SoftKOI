class InputProductsController < ApplicationController

  load_and_authorize_resource

  def index
    @input_products = InputProduct.all.order(created_at: :desc)
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

  def generate_chart
    @search = Report.new(params[:search])
    @products_to_pdf = @search.search_date_products
    @date_from = @search.date_from.to_date
    @date_to = @search.date_to.to_date
    @element = "Entrada de productos"
    @verb = "registradas"
    @element_by_query = "Entrada"
    redirect_to url_for(:controller => :reports, :action => :generate_chart, :param1 => @date_from, :param2 => @date_to, :param3 =>@element, :param4 => @verb, :param5 => @element_by_query)
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


  private

  def input_product_params
    params.require(:input_product).permit(:stock, :product_id)
  end

end
