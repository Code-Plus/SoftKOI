class Payment < ActiveRecord::Base
  belongs_to :sale

  validates :amount , presence: true
  validates :sale_id, presence: true

  before_create :set_date
  after_create :validate_amount
  before_update :set_updated_at


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

end
