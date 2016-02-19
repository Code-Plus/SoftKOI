class Product < ActiveRecord::Base
  include AASM
  belongs_to :category
  has_many :output_product
  has_many :input_product

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true  
  validates :stock_min, presence: true
  validates :state, presence: true
  validates :category_id, presence: true

  #El scope verifica y nos trae los productos que tengan estado disponible
  scope :activos, ->{ where(state: "disponible")}

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
