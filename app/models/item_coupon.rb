class ItemCoupon < ActiveRecord::Base
  belongs_to :sale
  belongs_to :coupon
end
