class InputProduct < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :stock, presence: true
  validates :create_at, presence: true
end
