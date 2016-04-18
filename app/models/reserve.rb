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
