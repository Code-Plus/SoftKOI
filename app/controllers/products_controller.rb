class ProductsController < ApplicationController
   before_action :set_product, only: [:edit, :update, :disponible, :noDisponible, :bajas ]

   def index
      @products = Product.all
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



   def disponible
      @product.disponible!
      redirect_to products_url
   end

   def noDisponible
      @product.noDisponible!
      redirect_to products_url
   end

   def bajas
      @product.bajas!
      redirect_to products_url
   end


   private

   def set_product
      @product = Product.find(params[:id])
   end

   def product_params
      params.require(:product).permit(:name, :description, :price, :state, :category_id, :stock_min, :stock)
   end
end
