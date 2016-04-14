class SalesController < ApplicationController

   before_action :set_sale, only: [:show, :edit, :update, :destroy]
   load_and_authorize_resource

   def index
      @sales = Sale.all
   end


   def show
   end

   def new
      @sale = Sale.new
   end

   def edit
   end


   def create
      @sale = current_user.sales.build(sale_params)

      respond_to do |format|
         if @sale.save
            format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
            format.json { render :show, status: :created, location: @sale }
         else
            format.html { render :new }
            format.json { render json: @sale.errors, status: :unprocessable_entity }
         end
      end
   end


   def update
      respond_to do |format|
         if @sale.update(sale_params)
            format.html { redirect_to sales_url, notice: 'Sale was successfully updated.' }
            format.json { render :show, status: :ok, location: @sale }
         else
            format.html { render :edit }
            format.json { render json: @sale.errors, status: :unprocessable_entity }
         end
      end
   end


   def destroy
      @sale.destroy
      respond_to do |format|
         format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
         format.json { head :no_content }
      end
   end

   def pago
      @sale.pago!
      redirect_to sales_url
   end

   def create_customer_association
      set_sale

      unless @sale.blank? || params[:customer_id].blank?
         @sale.customer_id = params[:customer_id]
         @sale.save
      end

      respond_to do |format|
         format.js { ajax_refresh }
      end
   end

   def sale_discount
      @sale = Sale.find(params[:sale_discount][:sale_id])

      @sale.discount = params[:sale_discount][:discount]
      @sale.save

      update_totals

      respond_to do |format|
         format.js { ajax_refresh }
      end
   end

   def destroy_item
      set_sale
      update_totals

      respond_to do |format|
         format.js { ajax_refresh }
      end
   end

   def update_totals
      set_sale
      @sale.amount = 0.00

      for item in @sale.items
         @sale.amount += item.total_price
      end

      total_amount = @sale.amount

      if @sale.discount.blank?
         @sale.total_amount = total_amount
      else
         discount_amount = @sale.discount
         @sale.total_amount = total_amount - discount_amount
      end
      @sale.save
   end

   def create_custom_customer
      set_sale

      custom_customer = Customer.new
      custom_customer.firstname = params[:custom_customer][:firstname]
      custom_customer.lastname = params[:custom_customer][:lastname]
      custom_customer.phone = params[:custom_customer][:phone]
      custom_customer.cellphone = params[:custom_customer][:cellphone]
      custom_customer.birthday = params[:custom_customer][:birthday]
      custom_customer.email = params[:custom_customer][:email]
      custom_customer.state = params[:custom_customer][:state]
      custom_customer.type_document_id = params[:custom_customer][:type_document_id]



      custom_customer.save

      @sale.add_customer(custom_customer.id)

      update_totals

      respond_to do |format|
         format.js { ajax_refresh }
      end
   end

   def add_comment
      set_sale
      @sale.comments = params[:sale_comment][:comment]
      @sale.save

      respond_to do |format|
         format.js { ajax_refresh }
      end
   end



   def update_totals

      set_sale

      @sale.amount = 0.00

      for item in @sale.items
         @sale.amount += item.total_price
      end

      total_amount = @sale.amount

      if @sale.discount.blank?
         @sale.total_amount = total_amount
      else
         discount_amount = @sale.discount
         @sale.total_amount = total_amount - discount_amount
      end

      @sale.save
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_sale
      if @sale.blank?
         if params[:sale_id].blank?
            if params[:search].blank?
               @sale = Sale.find(params[:id])
            else
               @sale = Sale.find(params[:search][:sale_id])
            end
         else
            @sale = Sale.find(params[:sale_id])
         end
      end
   end

   def ajax_refresh
      render(file: 'sales/ajax_reload.js.erb')
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def sale_params
      params.require(:sale).permit(:state, :amount, :total_amount, :discount, :limit_date, :user_id, :comment, :customer_id)
   end
end
