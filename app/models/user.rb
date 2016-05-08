class User < ActiveRecord::Base

	has_many :sales
	belongs_to :role
	belongs_to :type_document
	has_many :calendar

	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:document]

	validates :document, presence: true, numericality: { only_integer: true }, uniqueness: {case_sensitive: false}
	validates :name, presence: true
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :email, email: true, uniqueness: {case_sensitive: false}
	validates :phone, numericality: { only_integer: true }, length: { is: 7 }
	validates :cellphone, numericality: { only_integer: true }, length: { is: 10 }
	validates :state, presence: true

	include AASM

	aasm column: "state" do

		state :disponible, :initial => true
		state :noDisponible


		event :disponible do
			transitions from: :noDisponible, to: :disponible
		end

		event :noDisponible do
			transitions from: :disponible, to: :noDisponible
		end
	end


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
