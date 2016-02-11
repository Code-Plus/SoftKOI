class TypesClothingsController < ApplicationController
  before_action :set_types_clothing, only: [:show, :edit, :update, :destroy]

  # GET /types_clothings
  # GET /types_clothings.json
  def index
    @types_clothings = TypesClothing.all
  end

  # GET /types_clothings/1
  # GET /types_clothings/1.json
  def show
  end

  # GET /types_clothings/new
  def new
    @types_clothing = TypesClothing.new
  end

  # GET /types_clothings/1/edit
  def edit
  end

  # POST /types_clothings
  # POST /types_clothings.json
  def create
    @types_clothing = TypesClothing.new(types_clothing_params)

    respond_to do |format|
      if @types_clothing.save
        format.html { redirect_to @types_clothing, notice: 'Types clothing was successfully created.' }
        format.json { render :show, status: :created, location: @types_clothing }
      else
        format.html { render :new }
        format.json { render json: @types_clothing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /types_clothings/1
  # PATCH/PUT /types_clothings/1.json
  def update
    respond_to do |format|
      if @types_clothing.update(types_clothing_params)
        format.html { redirect_to @types_clothing, notice: 'Types clothing was successfully updated.' }
        format.json { render :show, status: :ok, location: @types_clothing }
      else
        format.html { render :edit }
        format.json { render json: @types_clothing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /types_clothings/1
  # DELETE /types_clothings/1.json
  def destroy
    @types_clothing.destroy
    respond_to do |format|
      format.html { redirect_to types_clothings_url, notice: 'Types clothing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_types_clothing
      @types_clothing = TypesClothing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def types_clothing_params
      params.require(:types_clothing).permit(:name)
    end
end
