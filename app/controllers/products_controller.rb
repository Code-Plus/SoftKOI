class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :disponible, :noDisponible]
  load_and_authorize_resource

  def index
    @products = Product.all.order(stock: :desc)
    @search = Report.new(params[:search])
  end



  def generate_pdf
    @search = Report.new(params[:search])
    @products_to_pdf = @search.search_date_products
    @date_from = @search.date_from.to_date
    @date_to = @search.date_to.to_date
    respond_to do |format|
      format.html
      format.pdf do
        pdf=ProductPdf.new(@products_to_pdf,@date_from,@date_to)
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
    @category = Category.select(:state).where(id: @product.category_id)
    @category = @category.pluck(:state)
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


  def change_state
    answer = params[:answer]
    respond_to do |format|
      if answer.to_i == 1
        category_product = Category.find(params[:id])
          product_by_category = Product.where(category_id: category_product.id)
          product_by_category.each do |product|
            OutputProduct.create stock: product.stock, product_id: product.id
            product.update stock:  0 ,state: "noDisponible"
            product.update state: "noDisponible"
          end
        category_product.state = "noDisponible"
        category_product.save!
        format.json { head :no_content}
      end
    end
  end

  def ajaxnewcategory
    @type_prduct_identify = params[:type_product]
    @query = Category.where(type_product_id: @type_prduct_identify, state: "disponible")
    @query_pluck = @query.pluck(:id, :name)
    @query_final = @query_pluck.map { |i, t| [ i, t ] }
    respond_to do |format|
      format.json { render json: @query_final }
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

  def disponible
    @product.disponible!
    redirect_to products_url
  end

  def noDisponible
      OutputProduct.create stock: @product.stock, product_id: @product.id
      @product.noDisponible!
      redirect_to products_url
  end

  def sinCantidad
    @product.sinCantidad!
    redirect_to products_url
  end

  def ajaxscripts
    respond_to do |format|
      format.js {render 'scripts.js.erb'}
    end
    puts "ESTOY EN EL ajaxscripts ------------------------------"
  end


  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name,:description, :price, :state, :category_id, :stock_min, :stock, :can_change)
  end
end
