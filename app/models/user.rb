class User < ActiveRecord::Base

	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:document]

	validates :document, presence: true, uniqueness: true
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :email, presence: true, email: true
	validates :phone, length: {maximum: 7} , numericality: { only_integer: true }
	validates :cellphone , length: {maximum: 12} , numericality: { only_integer: true }
	validates :role_id, presence: true
	validates :state, presence: true


	has_many :sales
	belongs_to :role

	def email_required?
		false
	end

	def email_changed?
		false
	end

	def name
		"#{firstname} #{lastname}"
	end

end
