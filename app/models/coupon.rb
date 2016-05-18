class Coupon < ActiveRecord::Base
  has_many :item_coupons
end
