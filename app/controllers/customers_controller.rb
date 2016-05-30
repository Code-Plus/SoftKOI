class CustomersController < ApplicationController

  before_action :set_customer, only: [ :edit, :update, :sinDeuda, :conDeuda]
  load_and_authorize_resource

  def index
    @customers = Customer.all
  end


  def generate_pdf
    @search = Report.new(params[:search])
    @customers_to_pdf = @search.search_date_customers
    @date_from = @search.date_from.to_date
    @date_to = @search.date_to.to_date
    respond_to do |format|
      format.html
      format.pdf do
        pdf=CustomerPdf.new(@customers_to_pdf,@date_from,@date_to)
        send_data pdf.render, filename: 'clientes.pdf',disposition: "inline",type: 'application/pdf'
      end
    end
  end

  def new
    @customer = Customer.new
    @type_document = TypeDocument.all
  end

  def edit
  end


  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Cliente actualizado satisfactoriamente!" }
      else
        format.json { render json: @customer.errors.full_messages,
          status: :unprocessable_entity }
        end
      end
  end


  def sinDeuda
      @customer.sinDeuda!
      redirect_to customers_url
   end

   def conDeuda
      @customer.conDeuda!
      redirect_to customer_url
   end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:document, :firstname, :lastname, :phone, :cellphone, :birthday, :email, :state, :type_document_id)
    end
end
