class ReservesController < ApplicationController
  before_action :set_reserve, only: [:show, :edit, :update, :destroy, :activa, :enProceso, :finalizada, :cancelada]
  protect_from_forgery except: :index

  # GET /reserves
  # GET /reserves.json
  def index
    @reserves = Reserve.all
    @reservesActivas = Reserve.activa
    @actualizarEstadoProceso = Reserve.validates_hour_start(Reserve.all)
    @actualizarEstadoFinalizada = Reserve.validates_hour_finish(Reserve.all)

    #render '/reserves/clock.js.erb'
=begin
    respond_to do |format|
      format.js {
         :template => '/reserves/clock.js.erb',
         :layout => false
      }
    end
=end
    #respond_to do |format|
    #  format.js { render '/reserves/clock.js.erb' }
    #end

  end

  # GET /reserves/1
  # GET /reserves/1.json
  def show
  end

  # GET /reserves/new
  def new
    @reserve = Reserve.new
    #@products = Reserve.validates_date_and_hour(Product.consolas, Reserve.all)
    @reserve_prices = ReservePrice.all
  end

  # GET /reserves/1/edit
  def edit
  end

  def cancelar
    @cancelarReserva = Reserve.cancel_reservation(Reserve.find(params[:reserve_id]))
  end

  # POST /reserves
  # POST /reserves.json
  def create
    @reserve = Reserve.create(reserve_params)

    respond_to do |format|
      if @reserve.save
         format.json { head :no_content }
            format.js {  flash[:notice] = "¡Reserva creada satisfactoriamente!" }
      else
        format.json { render json: @reserve.errors.full_messages,
               status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reserves/1
  # PATCH/PUT /reserves/1.json
  def update
    respond_to do |format|
      if @reserve.update(reserve_params)
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Reserva actualizada satisfactoriamente!" }
      else
        format.json { render json: @category.errors.full_messages,
               status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reserves/1
  # DELETE /reserves/1.json
  def destroy
    @reserve.destroy
    respond_to do |format|
      format.html { redirect_to reserves_url, notice: 'Reserve was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Métodos para los estados de la reserva.
  def activa
     @reserve.activa!
     redirect_to reserves_url
  end

  def enProceso
     @reserve.enProceso!
     redirect_to reserves_url
  end

  def finalizada
     @reserve.finalizada!
     redirect_to reserves_url
  end

  def cancelada
     @reserve.cancelada!
     redirect_to reserves_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserve
      @reserve = Reserve.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reserve_params
      params.require(:reserve).permit(:customer, :product_id, :date, :start_time, :end_time, :state, :price_reserve_id)
    end
end
