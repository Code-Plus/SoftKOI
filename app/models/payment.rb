class Payment < ActiveRecord::Base
  belongs_to :sale

  validates :amount , presence: true
  validates :sale_id, presence: true

  before_create :set_date
  after_create :validate_amount
  before_update :set_updated_at
  before_validation :validate_due, :validate_age


  private

  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end


  #Validar si la suma de todos los pagos es igual al valor total de la venta
  def validate_amount
    amount = sale.total_amount
    sales_id = sale.id
    sale_penalty = sale.penalty
    total_payment = 0
    total_amount_sale = amount + sale_penalty
    payments_query = Payment.where(sale_id: sales_id)
    payments_query.each do |payment|
      total_payment += payment.amount
    end
    if total_payment == total_amount_sale
      sale.customer.update(state: "sinDeuda")
      sale.pago!
    else
      unless sale.customer.state == "conDeuda"
        sale.customer.update(state: "conDeuda")
      end
    end
  end

  #Validar que no deba mas de 50.000
  def validate_due
    customer_due = 0
    customer_pay = 0
    sales_id = sale.id
    customer_info = sale.customer_id
    query_sale = Sale.where(customer_id: customer_info)
    query_sale.each do |sale|
      customer_due += sale.total_amount
      query_payment = Payment.where(sale_id: sale.id)
      query_payment.each do |pay|
        customer_pay += pay.amount
      end
    end
    if customer_due - customer_pay > 50000
      self.errors.add(:base ,"Ha exedido el limite de prestamo.")
    end
  end

  #Validar que un menor de edad no deba
  def validate_age
    customer_age = sale.customer.age
    if customer_age < 18
      unless self.amount == sale.amount
        self.errors.add(:base ,"Es menor de edad, no esta permitido darle prestamos.")
      end
    end

  end




end
