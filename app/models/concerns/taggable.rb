module Taggable
  extend ActiveSupport::Concern

=begin
  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
  end
=end
	before_create do
		self.created_at = Time.now.in_time_zone("Bogota")
		self.updated_at = Time.now.in_time_zone("Bogota")
	end

	before_update do
		self.updated_at = Time.now.in_time_zone("Bogota")
	end
end
