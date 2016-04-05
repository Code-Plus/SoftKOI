class Sale < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer

  include AASM

  validates :state, presence: true
  validates :amount, presence: true,  numericality: { only_integer: true }
  validates :total_amount, presence: true, numericality: { only_integer: true }
  validates :discount, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true
  validates :customer_id, presence: true
  validates_date :limit_date, presence: true, :afer => lambda { Date.current }

  before_validation :verificar_estado

  aasm column: "state" do
      state :pago
      state :sinpagar, :initial => true

      #Eventos de movimiento o transiciones para los estados.
      event :pago do
         transitions from: :sinpagar, to: :pago
      end
   end

   private

   def verificar_estado	
   		if self.amount == self.total_amount
   			self.state = "pago"
   		else
   			self.state = "sinpagar"
   		end
   end

end
