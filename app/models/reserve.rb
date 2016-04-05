class Reserve < ActiveRecord::Base
  include AASM

  belongs_to :products

  after_save :validar_hora

  #Validamos la hora fin para cambiar el estado.
  #after_save do
  #  t = Time.now
  #  t.strftime("%H:%M")
  #  if self.state == "enProceso" && self.end_time = t
  #    reserves.update_all state: "finalizada"
  #  end
  #end

  attr_accesor :state

  validates_each :state, on: :create, allow_blank: true, allow_nil: true do |record, attr, value|

  #Método para cambiar el estado "en proceso" mientras se cumplen las horas definidas.
  def validar_hora
    fecha = Time.new
    fecha.strftime("%F")
    while self.state == "activa"
      if self.date == fecha
        validates_time :booked_at, :between => [self.start_time, self.end_time]
        reserves.update_all state: "enProceso"
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
    end
  end
end
