class Customer < ActiveRecord::Base

  belongs_to :type_document
  has_many :sales
  include PublicActivity::Model

  include AASM

  before_create :set_date
  before_update :set_updated_at


  validates :document, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone , length: {maximum: 8} , numericality: { only_integer: true }
  validates	:cellphone , length: {maximum: 12} , numericality: { only_integer: true }
  validates_date :birthday, :before => lambda { 15.years.ago } ,:before_message => "Debe ser mayor de 15 años",presence: true
  validates :email, email: true
  validates :state, presence: true
  validates :type_document_id, presence: true

  #after_validation :validate_age_typeDocument

  #before_validation :validate_age_typeDocument


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
    age = (Date.today - birthday) / 365.25
    age = age.to_i
  end

  private

    def set_date
      self.created_at = Time.now.in_time_zone("Bogota")
      self.updated_at = Time.now.in_time_zone("Bogota")
    end

    def set_updated_at
      self.updated_at = Time.now.in_time_zone("Bogota")
    end

    def validate_age_typeDocument
      typeDocument = self.type_document.id
      unless(typeDocument == 1 && self.age >= 18) || (typeDocument == 2 && self.age < 17 )
        self.errors.add(:base ,"No se tiene la edad requerida para ese tipo de documento")
      end
    end
end
