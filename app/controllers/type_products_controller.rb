class TypeProductsController < ApplicationController
  before_action :set_type_product, only: [:edit, :update, :noDisponible, :disponible]

  def index
    @type_products = TypeProduct.all
  end

  def new
    @type_product = TypeProduct.new
  end


  def edit
  end


  def create
    @type_product = TypeProduct.create(type_product_params)

    respond_to do |format|
      if @type_product.save
        format.json { head :no_content }
        format.js 
      else
        format.json { render json: @type_product.errors.full_messages,
                            status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @type_product.update(type_product_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @type_product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end



  def disponible
    @type_product.disponible!
    redirect_to type_products_url
  end

  def noDisponible
    @type_product.noDisponible!
    redirect_to type_products_url
  end

  private

    def set_type_product
      @type_product = TypeProduct.find(params[:id])
    end

    def type_product_params
      params.require(:type_product).permit(:name, :description, :state)
    end
end
