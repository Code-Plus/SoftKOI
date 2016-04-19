class ReservePrice < ActiveRecord::Base
   
   has_many :reserves

   validates :value, presence: true, numericality: {greater_than: 0}
   validates :time, presence: true, numericality: {greater_than: 0}
   validates :console_id, presence: true

end
