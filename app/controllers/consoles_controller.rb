class ConsolesController < ApplicationController
  before_action :set_console, only: [:edit, :update, :disponible, :noDisponible, :baja]

  def index
    @consoles = Console.uso
  end

  def drop_console
    @dropConsole = Console.drop
  end

  def new
    @console = Console.new
  end

  def edit
  end

  def create
    @console = Console.create(console_params)

    respond_to do |format|
      if @console.save
        format.json { head :no_content }
            format.js {  flash[:notice] = "¡Consola creada satisfactoriamente!" }
      else
        format.json { render json: @category.errors.full_messages,
               status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @console.update(console_params)
       format.json { head :no_content }
            format.js {  flash[:notice] = "¡Consola actualizada satisfactoriamente!" }
      else
        format.json { render json: @category.errors.full_messages,
               status: :unprocessable_entity }
      end
    end
  end

  def disponible
      @console.disponible!
      redirect_to consoles_url
  end

  def noDisponible
    @console.noDisponible!
    redirect_to consoles_url
  end

  def baja
    @console.baja!
    redirect_to consoles_url
  end

  private
    def set_console
      @console = Console.find(params[:id])
    end

    def console_params
      params.require(:console).permit(:name, :description, :serial, :state)
    end
end
