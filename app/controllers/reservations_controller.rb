class ReservationsController < ApplicationController

  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :activa, :enProceso, :finalizada, :cancelada]
  load_and_authorize_resource

  def index
    @reservationsActivas = Reservation.activas_proceso
    @updateStateProceso = Reservation.validates_hour_start(Reservation.all)
    @updateStateFinalizada = Reservation.validates_hour_finish(Reservation.all)

    if @updateStateProceso.is_a?(Array)
      @updateStateProceso.each do |u|
        if u.is_a?(Numeric)
          gon.reserve_id = @updateStateProceso[0]
          gon.hour_start = @updateStateProceso[1]
        else
          gon.reserve_id = nil
          gon.hour_start = nil
        end
      end

    end
  end

  def query_console
    @console_identify = params[:consol]
    query = ReservePrice.select("reserve_prices.id, reserve_prices.time").where('console_id = ?', @console_identify)
    query.each do |q|
        puts "CONSULTA -> #{q.time }"
    end

    gon.answer_query = query
  end

  def reservations_end
    @reservations_end = Reservation.end_cancel_reservations
  end

  def change_state
    @respons = params[:respuesta]
    @id = params[:id]
    unless @respons.nil?
      if @respons.to_i == 1
        @identify = @id.to_i
        @r = Reservation.where(id: @identify).update_all(state: 'enProceso')
        puts "Estoy aca"
      #elsif @respons.to_i == 2
      #  render :edit
      elsif @respons.to_i == 3
        @identify = @id.to_i
        @r = Reservation.where(id: @identify).update_all(state: 'cancelada')
      elsif @respons.to_i == 0
        @identify = @id.to_i
        @r = Reservation.where(id: @identify).update_all(state: 'cancelada')
      end
    end

  end

  def show
  end

  def new
    @reservation = Reservation.new
    @reserve_prices = ReservePrice.all
    gon.console_id = 0
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
    puts "HOLI ESTA ES LA VARIABLE #{@update_price}"
    @reservation.cancelada!
    redirect_to reservations_url
  end

  def reserve_ajax
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
      params.require(:reservation).permit(:date, :start_time, :console_id,:end_time, :state, :customer, :reserve_price_id)
    end

end
