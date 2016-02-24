class OutputProduct < ActiveRecord::Base
	belongs_to :product

	validates :product_id, presence: true
end
