class InputProductsController < ApplicationController

   # GET /input_products
   # GET /input_products.json
   def index
      @input_products = InputProduct.all
   end

   # GET /input_products/new
   def new
      #Se obtiene el producto que se selecciono para la entrada
      @productx = Product.find(params[:product_id])
      @input_product = @productx.input_products.build
      #Traemos todo los productos que tengan estado "disponible"
      @product=Product.activos
   end


   # POST /input_products
   # POST /input_products.json
   def create
      @input_product = Product.new
      @input_product = InputProduct.new(input_product_params)
      @input_product.product = params[:stock]
      respond_to do |format|
         if @input_product.save
            format.json { head :no_content }
            format.js
         else
            format.json { render json: @category.errors.full_messages,
               status: :unprocessable_entity }
         end
      end
   end


   private
   # Use callbacks to share common setup or constraints between actions.
   #def set_input_product
   #   @input_product = InputProduct.find(params[:id])
   #end

   # Never trust parameters from the scary internet, only allow the white list through.
   def input_product_params
      params.require(:input_product).permit(:stock, :product_id)
   end

end
