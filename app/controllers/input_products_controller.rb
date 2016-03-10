class InputProductsController < ApplicationController


   def index
      @input_products = InputProduct.all
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
            format.json { head :no_content }
            format.js {  flash[:notice] = "¡Los productos se han ingresado satisfactoriamente!" }
         else
            format.json { render json: @input_product.errors.full_messages,
               status: :unprocessable_entity }
         end
      end
   end


   private

   def input_product_params
      params.require(:input_product).permit(:stock, :product_id)
   end

end
