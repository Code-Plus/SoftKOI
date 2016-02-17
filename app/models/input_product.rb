class InputProduct < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :stock, presence: true
  validates :stock_min, presence: true
  validates :update_at, presence: true
end
