class Payment < ActiveRecord::Base
  belongs_to :sale

  validates :amount , presence: true
  validates :sale_id, presence: true

  private

    # #Validar si la suma de todos los pagos es igual al valor total de la venta
    # def validate_amount
    #   amount = sale.total_amount
    #   sale = sale.id
    #   penalty = sale.penalty
    #   total_payment = 0
    #   total_amount_sale = amount + penalty
    #   #Consultar los pagos asociados a la venta
    #   payments_query = Payment.where("sale_id = ?"sale).SELECT("payment.id")
    #   #Transformar los pagos en un arreglo
    #   payments = payments_query.pluck(:id)
    #   #Recorrer el arreglo sumando todos los pagos
    #   payments.each do |payment|
    #     total_payment + = payment
    #   end
    #   #Valida si la suma de todos los pagos es igual a lo que debe pagar en la venta(total_amount + penalty)
    #   if total_payment == total_amount_sale
    #     sale.customer.update(state: "sinDeuda")
    #   end
    # end
    #
    # #Validar si la fecha actual es menor a la fecha limite de pago de la venta
    # #Si no es asi se le cobra un 10% por cada mes que se pase de la fehca limite de pago
    # def validate_penality
    # 	actually_date = DateTime.now.strftime("%m/%d/%y")
    # 	limit_date = sale.limit_date.strftime("%m/%d/%y")
    # 	actually_date_more_30_days = sale.limit_date + 30
    # 	actually_date_more_30_days_as_string = actually_date_more_30_days.strftime("%m/%d/%y")
    # 	#Validar que la fecha actual sea mayor que la fecha limit de pago
    # 	if actually_date > limit_date
    #     #Calcula el 10% del valor total de la venta
    #     porcent = sale.total_amount * 0.1
    #     porcent = porcent.to_i
    # 		sale.penalty.update(penalty: porcent)
    # 		#Validar si la fecha actual es 1 mes mayor que la fecha limite de pago
    # 		if limit_date >= actually_date_more_30_days_as_string
    # 			#Actualizar la multa pot todos los meses que se ha retrasado
    # 			begin
    #         res = true
    #         months = 2
    #         #Valida si tiene mas de 2 meses de retraso
    #         sum_days_per_months = DateTime.now + (30 * months)
    #         if limit_date > sum_days_per_months.strftime("%m/%d/%y")
    #           sale.penalty.update(penalty: porcent * months)
    #           mouths + = 1
    #         #Valida si solo tiene 1 mes de retraso
    #         elsif months == 2
    #           sale.penalty.update(penalty: porcent * months)
    #         else
    #           res == false
    #         end
    # 			end while res == true
    # 		end
    # 	end
    # end
end
