class ReservePrice < ActiveRecord::Base
   belongs_to :product


   def value_time
      "#{time} - #{value}"
   end
end
