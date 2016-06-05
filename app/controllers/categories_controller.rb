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
        format.js {  flash[:notice] = "¡Categoría creada satisfactoriamente!" }
      else
        format.json { render json: @category.errors.full_messages,status: :unprocessable_entity }
      end
    end
  end

  def update
    gon.category_id = @category.id
    respond_to do |format|
      if @category.update(category_params)
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Categoría actualizada satisfactoriamente!" }
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
      answer = params[:answer]
      unless answer.to_i != 1
        @category.noDisponible!
      end
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
