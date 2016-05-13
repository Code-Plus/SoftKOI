class Console < ActiveRecord::Base
  include AASM

  has_many :reserve_prices

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { in: 8..80 }
  validates :serial, presence: true, uniqueness: {case_sensitive: false}
  validates :state, presence: true

  scope :drop, -> { where(state: "baja")}
  scope :uso, -> { where("state = 'disponible' OR state = 'noDisponible'")	 }
  scope :disponible, -> { where(state: "disponible")}

  before_create :set_date
  before_update :set_updated_at



  aasm column: "state" do

		state :disponible, :initial => true
		state :noDisponible
		state :baja


		event :disponible do
			transitions from: :noDisponible, to: :disponible
		end

		event :noDisponible do
			transitions from: :disponible, to: :noDisponible
		end

		event :baja do
			transitions  from: :noDisponible, to: :baja
		end
	end

  private
  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

end
