class OutputProductsController < ApplicationController
  before_action :set_output_product, only: [:show]

  # GET /output_products
  # GET /output_products.json
  def index
    @output_products = OutputProduct.all
    @product = Product.activos_con_cantidad.all
  end

  # GET /output_products/1
  # GET /output_products/1.json
  def show
  end

  # GET /output_products/new
  def new
    @output_product = OutputProduct.new
    @product = Product.activos
  end

  # POST /output_products
  # POST /output_products.json
  def create
    @output_product = OutputProduct.new(output_product_params)
    @output_product.product = params[:stock]
    respond_to do |format|
      if @output_product.save
        format.html { redirect_to @output_product, notice: 'Output product was successfully created.' }
        format.json { render :show, status: :created, location: @output_product }
      else
        format.html { render :new }
        format.json { render json: @output_product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_output_product
      @output_product = OutputProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def output_product_params
      params.require(:output_product).permit(:stock, :product_id)
    end
end
