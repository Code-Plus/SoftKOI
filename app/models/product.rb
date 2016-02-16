class Product < ActiveRecord::Base
  include AASM
  belongs_to :category

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
