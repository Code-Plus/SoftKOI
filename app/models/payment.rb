class Payment < ActiveRecord::Base
  belongs_to :sale

  validates :amount , presence: true
  validates :penalty, presence: true
  validates :sale_id, presence: true

  private 

  #Validar si la suma de todos los pagos es igual al valor total de la venta
  def validate_amount
  	
  end

  #Validar si la fecha actual es menor a la fecha limite de pago de la venta
  def validate_penality
  	actually_date = Date.now.strftime("%m/%d/%y")
  	limit_date = sale.limit_date.strftime("%m/%d/%y")
  	actually_date_more_30_days = sale.limit_date.date + 30 
  	actually_date_more_30_days_as_string = actually_date_more_30_days.strftime("%m/%d/%y")
  	#Validar que la fecha actual sea mayor que la fecha limit de pago
  	if actually_date > limit_date
  		porcent = sale.total_amount * 1.1
  		self.penalty.update(penalty: porcent.to_i)
  		#Validar si la fecha actual es 1 mes mayor que la fecha limite de pago
  		if limit_date >= actually_date_more_30_days_as_string
  			#Actualizar la multa pot todos los meses que se ha retrasado
  			#begin

  			#end while 
  		end	
  	end
  end
end
