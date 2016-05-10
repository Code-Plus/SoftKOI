class Reservation < ActiveRecord::Base

  belongs_to :reserve_price

  include AASM

  #reservas en estado activas
  scope :activa, -> {find_by_sql('SELECT date, start_time, end_time, state FROM reservations WHERE state = "activa"')}

  #Reservas en estado activas y en proceso
  scope :activas_proceso, ->{where("state = 'activa' OR state = 'enProceso'")}

  #Reservas en estado enProceso
  scope :proceso, ->{where("state = 'enProceso'")}

  #Reservas en estado finalizada o cancelada
  scope :end_cancel_reservations, -> {where ("state = 'cancelada' OR state = 'finalizada'")}

  #Validaciones para los campos.
  # validates_date :date, presence: true, :on_or_after => lambda { Date.current }, :on_or_after_message => ' debe ser mayor a la actual'
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :customer, presence: true
  validates :reserve_price_id, presence: true
  before_validation :validate_times
  #before_save :validate_console_hour, :if => :condition_reservation?

  def condition_reservation?
    q = Reservation.where('state = "activa"')
    testt = q.pluck(:id)
    if testt.size > 1
      return true
    else
      return false
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

   #Método para pasar al estado "enProceso" de una reserva determinada cuando llegue a la hora registrada.
   def self.validates_hour_start(search)
      search = search.where(state: 'activa').select("id, date, start_time, state")
      search.each do |var|
         if var.date.strftime("%F") == Time.new.strftime("%F")
            if var.start_time.strftime("%H:%M") == Time.now.strftime("%H:%M")
               reserve_id = var.id.to_s
               minutes_of_hour = var.start_time.strftime("%H").to_i * 60
               minutes = var.start_time.strftime("%M").to_i
               hour_finish = minutes_of_hour + minutes
               return reserve_id, hour_finish
            end
         end
      end
   end

   #Método para pasar al estado "finalizada" de una reserva determinada cuando llegue a la hora registrada.
   def self.validates_hour_finish(search)
      search = search.where(state: 'enProceso').select("id, date, end_time, state")
      search.each do |var|
         if var.date.strftime("%F") == Time.new.strftime("%F")
            if var.end_time.strftime("%H:%M") == Time.now.strftime("%H:%M")
              Reservation.where(id: var.id).update_all(state: 'finalizada')
              reserve_id = var.id.to_s
              return reserve_id
            else
              return 0
            end
         end
      end
   end

  def self.cancel_reserve(reserve, current_time)
    console = reserve.reserve_price.console_id
    s_number = 120
    interval = 0
    id_precio= 0
    if reserve.state == "activa"
      Reservation.where(id: reserve.id).update_all(reserve_price_id: 0)
    elsif reserve.state == "enProceso" && reserve.reserve_price.console_id == console
      all_times_one = ReservePrice.select("reserve_prices.id, reserve_prices.time").where("console_id = ?", console)
      minimum_time = all_times_one.minimum(:time)
      price = ReservePrice.where("time = ?", minimum_time).select("reserve_prices.value")
      if current_time.strftime("%H").to_i == reserve.start_time.strftime("%H").to_i
        time_elapsed = (TimeDifference.between(current_time, reserve.start_time).in_minutes).round
      elsif current_time.strftime("%H").to_i != reserve.start_time.strftime("%H").to_i
        time_elapsed = (TimeDifference.between(current_time, reserve.start_time).in_minutes).round
      end
      all_times_one.each do |t|
        if time_elapsed == t.time
          interval = t.time
        elsif time_elapsed < t.time
          subtraction =   t.time - time_elapsed
          if subtraction < s_number
            s_number = subtraction
            interval = t.time
          end
        end
      end
      price_of_t = ReservePrice.where("time = ?", interval).select("reserve_prices.id")
      id_time = price_of_t.pluck(:id)
      id_time.each do |id_c|
      reserve.update(reserve_price_id: id_c)
      end
    end
  end

private
  def validate_times
    if self.start_time.strftime("%H:%M") >= Time.now.strftime("%H:%M")
      if self.start_time.strftime("%H:%M") >= self.end_time.strftime("%H:%M")
        self.errors.add(:base ,"Hora de  inicio mayor a la fin")
      end
    else
      self.errors.add(:base ,"La hora de inicio debe ser mayor a la actual")
    end
  end

  def validate_console_hour
    #raise ActiveRecord::Rollback
    current_date = Time.new.strftime("%F")
    reservations_where_state_activa = Reservation.where('state = "activa" and date = ?', current_date)
    pointer = reservations_where_state_activa.size
    #raise ActiveRecord::Rollback
    if pointer >= 1
      puts "PASÉ EL FILTRO"
      current_start_time = self.start_time
      puts "ESTE ES EL TIEMPO DE INICIO QUE ESTÁ EN EL FORM#{current_start_time}"
      id_price = self.reserve_price_id
      substraction_hours = 0
      get_console = ReservePrice.select("reserve_prices.console_id").where("id = ?", id_price)
      console_selected = get_console.pluck(:id)
      puts "ESTE ES EL ID DE LA CONSOLA QUE SELECCIONÓ#{console_selected}"
      get_times_for_console = Reservation.joins(:reserve_price).where('reserve_prices.console_id = ?', console_selected).select("reserve_prices.time")
      longer_registered = get_times_for_console.maximum(:time)
      puts "ESTE ES EL MAYOR TIEMPO REGISTRADO PARA LA CONSOLA#{longer_registered}"
      start_console_id = Reservation.joins(:reserve_price).where('reserve_prices.console_id = ?', console_selected).select("reservations.start_time")
      array_times_registered = start_console_id.pluck(:start_time)
      puts "ESTE ES EL ARREGLO DE LOS TIEMPOS REGISTRADOS PARA ESA CONSOLA#{array_times_registered}"
      array_times_registered.each do |time|
        substraction_hours = (TimeDifference.between(current_start_time, time).in_minutes).round
        puts "ESTA ES LA PUTA RESTA :C #{substraction_hours}"
        if substraction_hours <= longer_registered
          puts "LLEGUÉ HASTA ACÁ"
          self.errors.add(:base, "No se puede reservar a la hora elegida para esa consola")
          #raise ActiveRecord::Rollback
        else
          puts "LLEGUÉ AL ELSE"
          substraction_hours = 0
        end
      end
    else
      puts "Rompí el método"
    end
  end

end
