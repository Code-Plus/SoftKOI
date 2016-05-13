class Item < ActiveRecord::Base

  belongs_to :product
  belongs_to :sale


  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :total_price, presence: true, numericality: { only_integer: true }

  before_create :set_date
  before_update :set_updated_at

  private
  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end



end
