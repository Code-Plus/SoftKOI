class Payment < ActiveRecord::Base
  belongs_to :sale
end
