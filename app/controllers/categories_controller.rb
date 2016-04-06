class CategoriesController < ApplicationController

   before_action :set_category, only: [:edit, :update, :noDisponible, :disponible]
   load_and_authorize_resource

   def index
      @categories = Category.all
   end



   def new
      @category = Category.new
      @type_products = TypeProduct.activos
   end


   def edit
   end



   def create
      @category = Category.create(category_params)

      respond_to do |format|
         if @category.save
            format.json { head :no_content }
            format.js {  flash[:notice] = "¡Categoria creada satisfactoriamente!" }
         else
            format.json { render json: @category.errors.full_messages,
               status: :unprocessable_entity }
         end
      end
   end


   def update
      respond_to do |format|
         if @category.update(category_params)
            format.json { head :no_content }
            format.js {  flash[:notice] = "¡Categoria actualizada satisfactoriamente!" }
         else
            format.json { render json: @category.errors.full_messages,
               status: :unprocessable_entity }
         end
      end
   end


   #Cambia el estado a disponible
   def disponible
      @category.disponible!
      redirect_to categories_url
   end

   #Cambia el estado a no disponible
   def noDisponible
         @category.noDisponible!
         redirect_to categories_url
   end

   private

   def set_category
      @category = Category.find(params[:id])
   end


   def category_params
      params.require(:category).permit(:name, :description, :type_product_id, :can_change)
   end
end
