class Reserve < ActiveRecord::Base
  include AASM

  belongs_to :products

  #Se cambia el estado cuando la hora de inicio seleccionada es igual a la hora actual comparando la fecha.
  after_save do
    t = Time.now
    f = Time.new
    t.strftime("%H:%M")
    while self.state == "activa"
      if self.start_time = t && self.date = f
        reserves.update_all state: "enProceso"
      end
    end
  end

  #Validamos la hora fin para cambiar el estado.
  after_save do
    t = Time.now
    t.strftime("%H:%M")
    if self.state == "enProceso" && self.end_time = t
      reserves.update_all state: "finalizada"
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
