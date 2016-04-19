class ReservePricesController < ApplicationController
   
  before_action :set_reserve_price, only: [:edit, :update]
  load_and_authorize_resource

  # GET /reserve_prices
  # GET /reserve_prices.json
  def index
    @reserve_prices = ReservePrice.all
  end


  # GET /reserve_prices/new
  def new
    @reserve_price = ReservePrice.new
    @console = Console.disponible
  end

  # GET /reserve_prices/1/edit
  def edit
  end

  # POST /reserve_prices
  # POST /reserve_prices.json
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

  # PATCH/PUT /reserve_prices/1
  # PATCH/PUT /reserve_prices/1.json
  def update
    respond_to do |format|
      if @reserve_price.update(reserve_price_params)
       ormat.json { head :no_content }
        format.js {  flash[:notice] = "¡Precio de reserva actualizada satisfactoriamente!" }
      else
        format.json { render json: @reserve_price.errors.full_messages,
          status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserve_price
      @reserve_price = ReservePrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reserve_price_params
      params.require(:reserve_price).permit(:value, :time, :console_id)
    end
end
