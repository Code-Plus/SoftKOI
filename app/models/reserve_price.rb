class ReservePrice < ActiveRecord::Base
   belongs_to :console
   has_many :reserves

end
