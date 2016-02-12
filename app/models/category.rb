class Category < ActiveRecord::Base

	belongs_to :type_product
	has_many :products

end
