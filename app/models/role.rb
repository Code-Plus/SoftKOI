class Role < ActiveRecord::Base
	has_many :users

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
