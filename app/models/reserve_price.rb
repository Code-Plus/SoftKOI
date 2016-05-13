class ReservePrice < ActiveRecord::Base

  has_many :reservations
  belongs_to :console

  validates :value, presence: true, numericality: {greater_than: 0}
  validates :time, presence: true, numericality: {greater_than: 0}
  validates :console_id, presence: true

  before_create :set_date
  before_update :set_updated_at


  scope :searchconsole, -> (console_id) {where(:console_id => console_id)}

  scope :name_consoles, ->{joins("INNER JOIN console ON reserve_prices.console_id = consoles.id").select("reserve_prices.*, consoles.name")}

  def console_name
    return console.name
  end

  private
  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end
end
