class Sale < ActiveRecord::Base

	belongs_to :user
	belongs_to :customer
	has_many :items
	has_many :products, through: :items
	has_many :payments

	before_validation :verificar_estado
	before_create :default_date

	accepts_nested_attributes_for :items
	accepts_nested_attributes_for :payments

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

	#Obtener valor de la venta por cada pago
	def remaining_balance
    if self.total_amount.blank?
      balance = 0.00
    else
      balance = self.total_amount - paid_total
    end

    if balance < 0
      return 0
    else
      return balance.round(2)
    end
  end

  #Obtener el valor descontado de una venta
  def get_discounted_amount
    self.total_amount * self.discount
  end


  def paid_total
    paid_total = 0.00
    unless self.payments.blank?
      for payment in self.payments
        paid_total += payment.amount.blank? ? 0.00 : payment.amount
      end
    end
    return paid_total
  end

  #Devuelta
  def change_due
    if self.total_amount.blank?
      return 0.00
    else
      if paid_total > self.total_amount
        return paid_total - self.total_amount
      else
        return 0.00
      end
    end
  end

  def add_customer(customer_id)
    self.customer_id = customer_id
    self.save
  end

	private

	def verificar_estado
		if self.amount == self.total_amount
			self.state = "pago"
		else
			self.state = "sinpagar"
		end
	end

	# Fecha por defecto
	def default_date
		if self.limit_date.nil?
			self.limit_date = Time.now
		end
	end

end
