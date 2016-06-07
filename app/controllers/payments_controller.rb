class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show]
  load_and_authorize_resource

  def index
    # @payments = Payment.distinct(:sale_id)
    @payments = Payment.all
  end

  def show
  end

  def generate_sale_pdf
    #@coupon = params[:search_coupon]
    @pay_amount = 0
		@sale_to_pdf = params[:param1].to_i
		@payment_to_pdf = params[:param2].to_i
		@detail_sale = Item.where(sale_id: @sale_to_pdf)
		@user_do_payment = current_user.name
		@sale_to_pdf = Sale.where(id: @sale_to_pdf)
		@payment_to_pdf = Payment.where(id: @payment_to_pdf)
    all_payments = Payment.where(sale_id: @sale_to_pdf)
		@sale_to_pdf.each do |sale|
			@sale_id = sale.id
			@sale_amount = sale.amount
			if sale.discount.nil?
				@sale_discount = 0
			else
				@sale_discount = sale.amount * sale.discount
			end
      @sale_limit_date = sale.limit_date
			@sale_total_amount = sale.total_amount
      @sale_customer = sale.customer.name
      @sale_penalty = sale.penalty
		end
    all_payments.each do |pay|
      @pay_amount += pay.amount
    end
		respond_to do |format|
			format.js
			format.pdf do
				pdf=PaymentPdf.new(@sale_to_pdf,@detail_sale,@payment_to_pdf,@user_do_payment,@sale_id,@sale_limit_date,@sale_amount,@sale_discount,@sale_total_amount,@pay_amount,@sale_customer,@sale_penalty)
				send_data pdf.render, filename: 'pago.pdf',:disposition => "inline",type: 'application/pdf'
			end
		end
	end

  def make_payment
    @coupon_id = params[:search_coupon]
    @sale = Sale.find(params[:payments][:sale_id])
    cash_payment = params[:payments][:amount]
    sale_do_payment = Sale.find(params[:payments][:sale_id])
    customer_due = 0
    customer_pay = 0
    customer_due_actually = sale_do_payment.total_amount.to_i
    sales_id = @sale.id
    customer_info = @sale.customer_id
    query_sale = Sale.where(customer_id: customer_info, state: "sinPagar")

    unless cash_payment != nil
      cash_payment = 0
    end

    if (Coupon.exists? id: @coupon_id) || (@coupon_id.empty?)
      #Validar si el cupon existe para juntar su valor con el efectivo
      if @coupon_id.empty?
        sum_paid = cash_payment.to_i
      else
        coupon = Coupon.find(@coupon_id)
        sum_paid = coupon.amount.to_i + cash_payment.to_i
      end
      puts "#{sum_paid}-------------------->sum_paid"
      puts "#{customer_due_actually}----------->customer_due"
      #Validar que no quede debiendo mas de $50.000
      query_sale.each do |sale_olds|
        customer_due += sale_olds.total_amount
       if Payment.where(sale_id: sale_olds.id).exists?
         query_payment = Payment.where(sale_id: sale_olds.id)
         query_payment.each do |pay|
           customer_pay += pay.amount
         end
       else
         customer_pay = 0
       end
      end
      customer_pay += sum_paid


      if sum_paid > sale_do_payment.calculate_total_payment
        respond_to do |format|
          format.js { render :js => "toastr['error']('No puede pagar mas de lo que debe.')"}
        end
      elsif customer_due - customer_pay > 50000
        respond_to do |format|
          format.js { render :js => "toastr['error']('El cliente ha excedido el limite de prestamo.')"}
        end
      elsif (customer_due_actually - customer_pay > 0) && @sale.customer.age < 18
        respond_to do |format|
          format.js { render :js => "toastr['error']('El cliente es menor de edad, no puede tener deudas.')"}
        end
      else
        if @coupon_id.empty?
          payment_create = Payment.create(amount: params[:payments][:amount], sale_id: params[:payments][:sale_id])
          respond_to do |format|
            format.js { render :js => "window.open('/payments/generate_sale_pdf.pdf?param1="+@sale.id.to_s+"&amp;param2="+payment_create.id.to_s+"'),'_blank',window.location.href='/sales'"}
          end
        else

          if coupon.state == "noUtilizado"
            payment_create = Payment.create(amount: sum_paid, sale_id: params[:payments][:sale_id])
            coupon.update state: "utilizado"
            respond_to do |format|
              format.js { render :js => "window.open('/payments/generate_sale_pdf.pdf?param1="+@sale.id.to_s+"&amp;param2="+payment_create.id.to_s+"'),'_blank',window.location.href='/sales'"}
            end
          else
            respond_to do |format|
              format.js { render :js => "toastr['error']('El bono ya ha sido canjeado')"}
            end
          end

        end
      end
    else
      respond_to do |format|
        format.js { render :js => "toastr['error']('El bono no existe')"}
      end
    end
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:amount, :sale_id)
    end
end
