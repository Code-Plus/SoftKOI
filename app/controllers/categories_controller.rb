class CategoriesController < ApplicationController

   before_action :set_category, only: [:show, :edit, :update, :destroy, :noDisponible, :disponible]

   def index
      @categories = Category.order('created_at DESC').page(params[:page]).per_page(8)
   end

   def show
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
            format.js
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
            format.js
         else
            format.json { render json: @category.errors.full_messages,
               status: :unprocessable_entity }
         end
      end
   end

   def destroy
      @category.destroy
      respond_to do |format|
         format.html { redirect_to categories_url, notice: 'Categoria eliminada correctamente.' }
         format.json { head :no_content }
      end
   end

   #Se cambia el estado a disponible de las categorias
   def disponible
      @category.disponible!
      redirect_to @category
   end

   #Se cambia el estado a noDisponible de las categorias
   def noDisponible
      @category.noDisponible!
      redirect_to @category
   end

   private

   def set_category
      @category = Category.find(params[:id])
   end


   def category_params
      params.require(:category).permit(:name, :description, :type_product_id)
   end
end
