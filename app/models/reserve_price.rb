class ReservePrice < ActiveRecord::Base
   belongs_to :product
   has_many :reserves

end
