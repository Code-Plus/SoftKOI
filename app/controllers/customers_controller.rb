class CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @customers = Customer.all
  end

  def show
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
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
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
