class Sale < ActiveRecord::Base
	include PublicActivity::Model
	
	before_create :set_date, :default_date
	before_update :set_updated_at

	belongs_to :user
	belongs_to :customer

	has_many :items, dependent: :destroy
	has_many :products, through: :items
	has_many :payments, dependent: :destroy
	has_many :item_coupons


	accepts_nested_attributes_for :items, allow_destroy: true
	accepts_nested_attributes_for :products, allow_destroy: true
	accepts_nested_attributes_for :payments, allow_destroy: true

	# validates_date :limit_date, presence: true, :afer => lambda { Date.current }

	#Ventas registradas en la ultima semana
	scope :registered_last_week, ->{group("sales.created_at::date").where("created_at >= ? ", 1.week.ago ).count}

	#total_amount mayor que 0
	scope :total_amount_more_0, ->{joins(:payments).where(payments: {sale_id: ids}).where("total_amount > 0").distinct}

	include AASM

	aasm column: "state" do
		state :sinPagar, :initial => true
		state :pago
		state :anulada

		# Eventos de movimiento o transiciones para los estados.
		event :pago do
			transitions from: :sinPagar, to: :pago
		end

		event :anulada do
			transitions from: :pago, to: :anulada
		end

	end

	# Obtener valor de la venta por cada pago
	def remaining_balance
    if self.total_amount.blank?
      balance = 0
		elsif self.penalty -  paid_total > 0
			balance = self.total_amount
    else
			balance = self.total_amount - paid_total
    end

    if balance <= 0
      return 0
    else
      return balance
    end
  end

	#Calcular lo que se debe de una venta
	def calculate_total_payment
		if self.total_amount.blank?
			balance = 0
		else
			balance = (self.total_amount + self.penalty) - paid_total
		end

		if balance <= 0
      return 0
    else
      return balance
    end
	end
	#Obtener el valor que ha pagado de las multas
	def remaining_balance_penalty
		if self.total_amount.blank? || self.penalty == 0
			balance = 0
		elsif self.penalty -  paid_total <= 0
			balance = 0
		else
			balance = self.penalty - paid_total
		end

		if balance <= 0
      return 0
    else
      return balance
    end
	end

  # Obtener el valor descontado de una venta
  def get_discounted_amount
		if self.discount.nil?
			0
		else
			self.amount * self.discount
		end

  end

  # Valor total en todos los pagos
  def paid_total
    paid_total = 0
    unless self.payments.blank?
      for payment in self.payments
        paid_total += payment.amount.blank? ? 0 : payment.amount
      end
    end
    return paid_total
  end

  # Devuelta
  def change_due
    if self.total_amount.blank?
      return 0
    else
      if paid_total > self.total_amount
        return paid_total - self.total_amount
      else
        return 0
      end
    end
  end

  # Asociar cliente a venta
  def add_customer(customer_id)
    self.customer_id = customer_id
    self.save
  end

	#Parsear el limit_date
	def limit_date_parse
		date = self.limit_date
		date = date.to_date
		return date
	end
	private

	# Fecha por defecto
	def default_date
		if self.limit_date.strftime("%F") < Time.now.strftime("%F")
			new_limit_date = Time.now + 3.days
			self.limit_date = new_limit_date.strftime("%Y/%m/%d")
		end
	end

	def set_date
		self.created_at = Time.now.in_time_zone("Bogota")
		self.updated_at = Time.now.in_time_zone("Bogota")
	end

	def set_updated_at
		self.updated_at = Time.now.in_time_zone("Bogota")
	end

end
