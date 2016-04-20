class ReservePrice < ActiveRecord::Base

   has_many :reservations
   belongs_to :console

   validates :value, presence: true, numericality: {greater_than: 0}
   validates :time, presence: true, numericality: {greater_than: 0}
   validates :console_id, presence: true

end
