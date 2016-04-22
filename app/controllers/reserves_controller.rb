class ReservesController < ApplicationController

  before_action :set_reserve, only: [:show, :edit, :update, :destroy, :activa, :enProceso, :finalizada, :cancelada]
  load_and_authorize_resource :class => false

  # GET /reserves
  # GET /reserves.json
  def index
    @reserves = Reserve.all
    @reservesActivas = Reserve.activa
    @actualizarEstadoProceso = Reserve.validates_hour_start(Reserve.all)
    @actualizarEstadoFinalizada = Reserve.validates_hour_finish(Reserve.all)
  end

  def show

  end

  def new
    @reserve = Reserve.new
    @reserve_prices = ReservePrice.all
  end

  def edit
  end

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
    @update_price = Reserve.cancel_reserve(Reserve.find(params[:id]), Time.now)
    @reserve.cancelada!
    redirect_to reserves_url
  end

  def Reserve_ajax
    @reserve_price_reserve = ReservePrice.find(params[:id_reserve_price_selected])
    respond_to do |format|
      format.json {render json: @reserve_price_reserve}
    end
  end

  private

    def set_reserve
      @reserve = Reserve.find(params[:id])
    end


    def reserve_params
      params.require(:reserve).permit(:customer,:console_id, :date, :start_time, :end_time, :state, :reserve_price_id)

    end

end
