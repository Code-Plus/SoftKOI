class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :noDisponible, :disponible]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.order('created_at DESC').page(params[:page]).per_page(5)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    #Traemos la informacion de la tabla TypeProducts
    @type_products = TypeProduct.all 
  end

  #En este metodo cambiaremos el estado a disponible de las categorias
  def disponible
    @category.disponible!
    redirect_to @category
  end
  #En este metodo se cambia el estado a noDisponible de las categorias
  def noDisponible
    @category.noDisponible!
    redirect_to @category
  end


  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Categoria creada correctamente.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Categoria actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Categoria eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      #Se le mandan como parametros los campos de la base de datos de la tabla Category
      params.require(:category).permit(:name, :description, :type_product_id)
    end
end
