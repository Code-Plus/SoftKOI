class Sale < ActiveRecord::Base

	before_create :set_date
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

	# validates :state, presence: true
	# validates :amount, presence: true,  numericality: { only_integer: true, greater_than: 0 }
	# validates :total_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
	# validates :discount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	# validates :user_id, presence: true
	# validates :customer_id, presence: true
	# validates_date :limit_date, presence: true, :afer => lambda { Date.current }

	#Ventas registradas en la ultima semana
	scope :registered_last_week, ->{group("sales.created_at::date").where("created_at >= ? ", 1.week.ago ).count}

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
    else
      balance = self.total_amount - paid_total
    end

    if balance < 0
      return 0
    else
      return balance
    end
  end

  # Obtener el valor descontado de una venta
  def get_discounted_amount
		unless self.discount.nil?
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

	private



	# Fecha por defecto
	def default_date
		if self.limit_date.nil?
			self.limit_date = Time.now
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
