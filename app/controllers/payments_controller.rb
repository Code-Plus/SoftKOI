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
    respond_to do |format|
      format.html
      format.pdf do
        pdf=SalePdf.new()
        send_data pdf.render, filename: 'sale.pdf',disposition: "inline",type: 'application/pdf'
      end
    end
  end

  def make_payment
    @sale = Sale.find(params[:payments][:sale_id])
    Payment.create(amount: params[:payments][:amount], sale_id: params[:payments][:sale_id])

    respond_to do |format|
      format.js
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
