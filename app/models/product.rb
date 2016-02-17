class Product < ActiveRecord::Base
  include AASM
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  scope :activos, ->{where (state: "disponible")}

  aasm column: "state" do

    state :disponible, :initial => true

    state :noDisponible

    event :disponible do
      transitions from: :noDisponible, to: :diponible
    end
    event :noDisponible do
      transitions from: :disponible, to: :noDisponible
    end
  end

end
