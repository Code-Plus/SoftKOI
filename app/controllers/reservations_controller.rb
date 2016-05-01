class ReservationsController < ApplicationController

  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :activa, :enProceso, :finalizada, :cancelada]
  load_and_authorize_resource

  def index
    @reservations = Reservation.all
    @reservationsActivas = Reservation.activa
    @actualizarEstadoProceso = Reservation.validates_hour_start(Reservation.all)
    @actualizarEstadoFinalizada = Reservation.validates_hour_finish(Reservation.all)

    if @actualizarEstadoProceso.is_a?(Array)
      gon.reserve_id = nil
    else
      gon.reserve_id = @actualizarEstadoProceso
    end

  end

  def change_state
    @respons = params[:respuesta]
    @id = params[:id]

    unless @respons.nil?
      if @respons.to_i == 1
        @identify = @id.to_i
        @r = Reservation.where(id: @identify).update_all(state: 'enProceso')
      elsif @respons.to_i == 2
        @identify = @id.to_i
        postpone_reserve(@identify)
      elsif @respons.to_i == 3
        @identify = @id.to_i
        @r = Reservation.where(id: @identify).update_all(state: 'cancelada')
      end
    end

  end

  def postpone_reserve(id)
    Reservation.find(id)
  end

  def show

  end

  def new
    @reservation = Reservation.new
    @consoles = Console.all
    @reserve_prices = ReservePrice.all
  end

  def edit
  end

  def create
    @reservation = Reservation.create(reservation_params)

    respond_to do |format|
      if @reservation.save
         format.json { head :no_content }
            format.js {  flash[:notice] = "¡Reserva creada satisfactoriamente!" }
      else
        format.json { render json: @reservation.errors.full_messages,status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Reserva actualizada satisfactoriamente!" }
      else
        format.json { render json: @reservation.errors.full_messages,status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Métodos para los estados de la reserva.
  def activa
     @reservation.activa!
     redirect_to reservations_url
  end

  def enProceso
     @reservation.enProceso!
     redirect_to reservations_url
  end

  def finalizada
     @reservation.finalizada!
     redirect_to reservations_url
  end

  def cancelada
    @update_price = Reservation.cancel_reserve(Reservation.find(params[:id]), Time.now)
    @reservation.cancelada!
    redirect_to reservations_url
  end

  def Reserve_ajax
    @reserve_price_reserve = ReservePrice.find(params[:id_reserve_price_selected])
    respond_to do |format|
      format.json {render json: @reserve_price_reserve}
    end
  end

  private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:date, :start_time, :end_time, :state, :customer, :console_id, :reserve_price_id)
    end

end
