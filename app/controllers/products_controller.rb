class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :disponible, :noDisponible, :bajas, :products_low ]
  after_action :products_low, only:[:update]
  load_and_authorize_resource

  def index
    @products = Product.all
    @search = Report.new(params[:search])
  end

  def generate_pdf
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


  def new
    @product = Product.new
    @categories = Category.activos.order(name: :desc)
    @type_products = TypeProduct.activos.order(name: :asc)
  end


  def edit
  end


  def create
    @product = Product.create(product_params)
    respond_to do |format|
      if @product.save
        format.json { head :no_content}
        format.js { flash[:notice] = "¡Producto creado satisfactoriamente!" }
      else
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @product.update(product_params)
        format.json { head :no_content}
        format.js {  flash[:notice] = "¡Producto actualizado satisfactoriamente!" }
      else
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def products_low
    if @product.stock <= @product.stock_min
      @product.create_activity key: 'se esta agotando', read_at: nil
    end
  end



  def disponible
    @product.disponible!
    redirect_to products_url
  end

  def noDisponible
    @product.noDisponible!
    redirect_to products_url
  end

  def sinCantidad
    @product.sinCantidad!
    redirect_to products_url
  end


  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name,:description, :price, :state, :category_id, :stock_min, :stock, :can_change)
  end
end
