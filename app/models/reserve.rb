class Reserve < ActiveRecord::Base
  include AASM

  belongs_to :products

  #Validaciones.
  validates :customer, presence: true
  validates :product_id, presence: true
  validates :end_time, presence: true
  validates :price_reserve_id, presence: true

  #Método para validar que solo se reserve la consola en una hora y una fecha dada.
=begin
  def self.validates_date_and_hour(consoles, reserves)
    consoles.each do |c|
      reserves.each do |r|
        if c.id == r.product_id
          validates_date :date, :after => r.date
          validates_time :start_time, :after => r.start_time
          validates_time :start_time, :before => r.start_time
        end
      end
    end
  end
=end

  scope :activa, -> {find_by_sql('SELECT date, start_time, end_time, state FROM reserves WHERE state = "activa"')}

  #Método para pasar al estado "enProceso" de una reserva determinada cuando llegue a la hora registrada.
  def self.validates_hour_start(search)
    search = search.where(state: 'activa').select("id, date, start_time, state")
    search.each do |var|
      if var.date.strftime("%F") == Time.new.strftime("%F")
        if var.start_time.strftime("%H:%M") == Time.now.strftime("%H:%M")
          var.update state: "enProceso"
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
          var.update state: "finalizada"
        end
      end
    end
  end

  #Método de cancelar reserva, validando que no esté ni finalizada ni cancelada.
  def self.cancel_reservation(reserve)
    if reserve.state == "finalizada"
      self.errors.add(:state ,"La reserva está finalizada.")
    elsif reserve.state == "cancelada"
      self.errors.add(:state ,"La reserva ya se encuentra cancelada.")
    else
      self.update state: "cancelada"
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
