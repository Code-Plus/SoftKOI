class Customer < ActiveRecord::Base

  belongs_to :type_document
  has_many :sales

  include AASM

=begin
  validates :document, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone , length: {maximum: 7} , numericality: { only_integer: true }
  validates	:cellphone , length: {maximum: 12} , numericality: { only_integer: true }
  validates_date :birthday, :before => lambda { 15.years.ago } ,:before_message => "Debe ser mayor de 15 años",presence: true
  validates :email, email: true
  validates :state, presence: true
  validates :type_document_id, presence: true
=end

  aasm column: "state" do
    state :sinDeuda, :initial => true
    state :conDeuda

    #Eventos de movimiento o transiciones para los estados.
    event :sinDeuda do
      transitions from: :conDeuda, to: :sinDeuda
    end

    event :conDeuda do
      transitions from: :sinDeuda, to: :conDeuda
    end
  end

  def to_s
    document
  end

  def name
    "#{firstname} #{lastname}"
  end

  def age
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years #for days before birthday
  end

end
