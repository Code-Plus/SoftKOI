class Coupon < ActiveRecord::Base
  attr_reader :sale_id
  has_many :item_coupons
  before_create :set_date
	before_update :set_updated_at

  #before_validation :validate_date_sale

  # def initialize(params)
  #   params ||={}
  #     @sale_id = 0
  # end

  validates :amount, presence: true

  private
  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def validate_date_sale
    sale_date = item_coupons.sale.created_at
    sale_date_more_3 = sale_date + 3.days
    unless sale_date_more_3 <= Time.now
      self.errors.add(:base, "Se ha excedido en la fecha para realizar un cambio." )
    end
  end
end
