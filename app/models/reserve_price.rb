class ReservePrice < ActiveRecord::Base

   has_many :reservations
   belongs_to :console

   validates :value, presence: true, numericality: {greater_than: 0}
   validates :time, presence: true, numericality: {greater_than: 0}
   validates :console_id, presence: true

    scope :name_consoles, ->{joins("INNER JOIN console ON reserve_prices.console_id = consoles.id").select("reserve_prices.*, consoles.name")}

    def console_name
      return console.name
    end
end
