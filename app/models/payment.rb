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
    #sale_penalty = sale.penalty
    total_payment = 0
    total_amount_sale = amount# + sale_penalty
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
=begin
  #Validar si la fecha actual es menor a la fecha limite de pago de la venta
  #Si no es asi se le cobra un 10% por cada mes que se pase de la fehca limite de pago
  def validate_penality
  	actually_date = DateTime.now.strftime("%m/%d/%y")
  	limit_date = sale.limit_date.strftime("%m/%d/%y")
  	actually_date_more_30_days = sale.limit_date + 30
  	actually_date_more_30_days_as_string = actually_date_more_30_days.strftime("%m/%d/%y")
  	if actually_date > limit_date
      porcent = sale.total_amount * 0.1
      porcent = porcent.to_i
  		sale.penalty.update(penalty: porcent)
  		if limit_date >= actually_date_more_30_days_as_string
  			begin
          res = true
          months = 2
          sum_days_per_months = DateTime.now + (30 * months)
          if limit_date > sum_days_per_months.strftime("%m/%d/%y")
            sale.penalty.update(penalty: porcent * months)
            mouths + = 1
          elsif months == 2
            sale.penalty.update(penalty: porcent * months)
          else
            res == false
          end
  			end while res == true
  		end
  	end
  end
=end

end
