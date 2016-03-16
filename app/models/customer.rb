class Customer < ActiveRecord::Base
  belongs_to :type_document

  include AASM

  validates :document, presence: true, uniqueness: true
  validates :fistname, presence: true
  validates :lastname, presence: true
  validates :phone , length: {maximun: 7} , numericality: { only_integer: true }
  validates	:cellphone , length: {maximun: 12} , numericality: { only_integer: true }
  validates_date :birthday, :before => lambda { Date.current } ,presence: true
  validates :email, email: true
  validates :state, presence: true
  validates :type_document_id, presence true


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
end
