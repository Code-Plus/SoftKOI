class TypeDocument < ActiveRecord::Base
	has_many :customers
	has_many :users

end
