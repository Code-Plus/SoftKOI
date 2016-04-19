class Reserve < ActiveRecord::Base
  include AASM

  belongs_to :reserve_price
  belongs_to :console
  #Validaciones.

  scope :activa, -> {find_by_sql('SELECT date, start_time, end_time, state FROM reserves WHERE state = "activa"')}

  #Método para pasar al estado "enProceso" de una reserva determinada cuando llegue a la hora registrada.
  def self.validates_hour_start(search)
    #Se hace la consulta con el arreglo de las reservas que llega
    search = search.where(state: 'activa').select("id, date, start_time, state")
    search.each do |var|
      #Se recorre el arreglo de la consulta y se compara la fecha del sistema.
      if var.date.strftime("%F") == Time.new.strftime("%F")
        #Luego se valida la hora de inicio con la hora del sistema
        if var.start_time.strftime("%H:%M") == Time.now.strftime("%H:%M")
          #Se actualiza el estado.
          var.update state: "enProceso"
        end
      end
    end
  end

  #Método para pasar al estado "finalizada" de una reserva determinada cuando llegue a la hora registrada.
  def self.validates_hour_finish(search)
    #Se hace la consulta con el arreglo de las reservas que llega
    search = search.where(state: 'enProceso').select("id, date, end_time, state")
    search.each do |var|
      #Se recorre el arreglo de la consulta y se compara la fecha del sistema.
      if var.date.strftime("%F") == Time.new.strftime("%F")
        #Luego se valida la hora fin con la hora del sistema
        if var.end_time.strftime("%H:%M") == Time.now.strftime("%H:%M")
          #Se actualiza el estado
          var.update state: "finalizada"
        end
      end
    end
  end

  def self.cancel_reserve(reserve, current_time)
    console = reserve.console_id
    if reserve.state == "activa"
      reserve.update(reserve_price_id: 0)
    elsif reserve.state == "enProceso" && reserve.console_id == console

      all_times_one = ReservePrice.select("reserve_prices.time").where("console_id = ?", console)
      minimum_time = all_times_one.minimum(:time)
      price = ReservePrice.where("time = ?", minimum_time).select("reserve_prices.value")

      if current_time.strftime("%H").to_i == reserve.start_time.strftime("%H").to_i
        time_elapsed = current_time.strftime("%M").to_i - reserve.start_time.strftime("%M").to_i
      elsif current_time.strftime("%H").to_i != reserve.start_time.strftime("%H").to_i
        diference_for_hour = (current_time.strftime("%H").to_i - reserve.start_time.strftime("%H").to_i)
        hour_in_minutes = diference_for_hour * 60
        if current_time.strftime("%M").to_i == reserve.start_time.strftime("%M").to_i
          diference_for_minutes = current_time.strftime("%M").to_i - reserve.start_time.strftime("%M").to_i
          time_elapsed = hour_in_minutes + diference_for_minutes
        end
      end

      all_times_one.each do |t|
        if time_elapsed == t
          price_of_t = ReservePrice.where("time = ?", t).select("reserve_prices.value")
          reserve.update(reserve_price_id: price_of_t)
        elsif time_elapsed < t

        end

        if t == minimum_time
          if time_elapsed <= minimum_time
            reserve.update(reserve_price_id: price)
          end
        elsif time_elapsed >= t.time
          price_of_t = ReservePrice.where("time = ?", t).select("reserve_prices.value")
          reserve.update(reserve_price_id: price_of_t)
        end
      end
    end
  end

  aasm column: "state" do
    state :activa, :initial => true
    state :enProceso
    state :finalizada
    state :cancelada

    event :activa do
      transitions from: :cancelada, to: :activa
    end

    event :enProceso do
      transitions from: :activa, to: :enProceso
    end

    event :finalizada do
      transitions from: :enProceso, to: :finalizada
    end

    event :cancelada do
      transitions from: :activa, to: :cancelada
      transitions from: :enProceso, to: :cancelada
    end
  end

end
