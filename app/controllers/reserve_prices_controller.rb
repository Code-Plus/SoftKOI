class ReservePricesController < ApplicationController

  before_action :set_reserve_price, only: [:edit, :update]
  load_and_authorize_resource

  def index
    @reserve_prices = ReservePrice.all
  end



  def new
    @reserve_price = ReservePrice.new
    @console = Console.disponible
  end


  def edit
  end


  def create
    @reserve_price = ReservePrice.new(reserve_price_params)

    respond_to do |format|
      if @reserve_price.save
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Precio de reserva creado satisfactoriamente!" }
      else
        format.json { render json: @reserve_price.errors.full_messages,
          status: :unprocessable_entity }
        end
      end
    end


  def update
    respond_to do |format|
      if @reserve_price.update(reserve_price_params)
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Precio de reserva actualizada satisfactoriamente!" }
      else
        format.json { render json: @reserve_price.errors.full_messages,
          status: :unprocessable_entity }
      end
    end
  end

  private

  def set_reserve_price
    @reserve_price = ReservePrice.find(params[:id])
  end

  def reserve_price_params
    params.require(:reserve_price).permit(:value, :time, :console_id)
  end
  end
