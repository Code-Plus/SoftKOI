class InputProductsController < ApplicationController
  before_action :set_input_product, only: [:show, :edit, :update, :destroy]

  # GET /input_products
  # GET /input_products.json
  def index
    @input_products = InputProduct.all
  end

  # GET /input_products/1
  # GET /input_products/1.json
  def show
  end

  # GET /input_products/new
  def new
    @input_product = InputProduct.new
    #Traemos todo los productos que tengan estado "disponible"
    @product=Product.activos.precios


    #@precios = Product.by_name(params[:product][:name]).prices
  end

  # GET /input_products/1/edit
  def edit
  end

  # POST /input_products
  # POST /input_products.json
  def create
    @input_product = InputProduct.new(input_product_params)
    @input_product.product = params[:stock]
    respond_to do |format|
      if @input_product.save
        format.html { redirect_to @input_product, notice: 'Input product was successfully created.' }
        format.json { render :show, status: :created, location: @input_product }
      else
        format.html { render :new }
        format.json { render json: @input_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /input_products/1
  # PATCH/PUT /input_products/1.json
  def update
    respond_to do |format|
      if @input_product.update(input_product_params)
        format.html { redirect_to @input_product, notice: 'Input product was successfully updated.' }
        format.json { render :show, status: :ok, location: @input_product }
      else
        format.html { render :edit }
        format.json { render json: @input_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /input_products/1
  # DELETE /input_products/1.json
  def destroy
    @input_product.destroy
    respond_to do |format|
      format.html { redirect_to input_products_url, notice: 'Input product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_input_product
      @input_product = InputProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def input_product_params
      params.require(:input_product).permit(:stock, :product_id)
    end

end
