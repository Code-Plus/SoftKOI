class InputProductsController < ApplicationController

   load_and_authorize_resource

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
            format.html { redirect_to products_path, notice: 'La entrada se ha registrado correctamente' }
            format.json { render :index, status: :created, location: @input_product }
         else
             format.html { render :new }
            format.json { render json: @input_product.errors, status: :unprocessable_entity }
         end
      end
   end


   private

   def input_product_params
      params.require(:input_product).permit(:stock, :product_id)
   end

end
