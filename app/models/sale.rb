class Sale < ActiveRecord::Base

  belongs_to :user
  belongs_to :customer
  has_many :items
  has_many :payments

  before_validation :verificar_estado
  before_create :default_date

  accepts_nested_attributes_for :items

  include AASM

  validates :state, presence: true
  validates :amount, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  validates :total_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :discount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  validates :customer_id, presence: true
  validates_date :limit_date, presence: true, :afer => lambda { Date.current }


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

   def default_date
     if self.limit_date.nil?
        self.limit_date = Time.now
     end
   end

end
