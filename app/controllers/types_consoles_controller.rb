class TypesConsolesController < ApplicationController
  before_action :set_types_console, only: [:show, :edit, :update, :destroy]

  # GET /types_consoles
  # GET /types_consoles.json
  def index
    @types_consoles = TypesConsole.all
  end

  # GET /types_consoles/1
  # GET /types_consoles/1.json
  def show
  end

  # GET /types_consoles/new
  def new
    @types_console = TypesConsole.new
  end

  # GET /types_consoles/1/edit
  def edit
  end

  # POST /types_consoles
  # POST /types_consoles.json
  def create
    @types_console = TypesConsole.new(types_console_params)

    respond_to do |format|
      if @types_console.save
        format.html { redirect_to @types_console, notice: 'Types console was successfully created.' }
        format.json { render :show, status: :created, location: @types_console }
      else
        format.html { render :new }
        format.json { render json: @types_console.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /types_consoles/1
  # PATCH/PUT /types_consoles/1.json
  def update
    respond_to do |format|
      if @types_console.update(types_console_params)
        format.html { redirect_to @types_console, notice: 'Types console was successfully updated.' }
        format.json { render :show, status: :ok, location: @types_console }
      else
        format.html { render :edit }
        format.json { render json: @types_console.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /types_consoles/1
  # DELETE /types_consoles/1.json
  def destroy
    @types_console.destroy
    respond_to do |format|
      format.html { redirect_to types_consoles_url, notice: 'Types console was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_types_console
      @types_console = TypesConsole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def types_console_params
      params.require(:types_console).permit(:name)
    end
end
