class Product < ActiveRecord::Base
  include AASM
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true


  aasm column: "state" do

    state :Disponible, :initial => true

    state :NoDisponible

    event :Disponible do
      transitions from: :NoDisponible, to: :Diponible
    end
    event :NoDisponible do
      transitions from: :Disponible, to: :NoDisponible
    end
  end

end
