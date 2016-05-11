class User < ActiveRecord::Base

	has_many :sales
	belongs_to :role
	belongs_to :type_document
	has_many :calendar

	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:document]


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
