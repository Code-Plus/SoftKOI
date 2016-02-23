class OutputProductsController < ApplicationController
  before_action :set_output_product, only: [:show]

  def index
  	@products = Product.all 
  end

  def show

  end

  def new
    @output_product = OutputProduct.new
    @products = Product.all 
  end

  def disponible
    @product.disponible!
    redirect_to @product
  end

  def deBaja
    @product.deBaja!
    redirect_to @output_product
  end

  def create
    @_product = OutputProduct.new(output_product_params)

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
      params.require(:output_product).permit(:product_id)
    end
end
