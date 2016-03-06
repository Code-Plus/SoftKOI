class OutputProductsController < ApplicationController
   before_action :set_output_product, only: [:show]

   def index
      @output_products = OutputProduct.all
      @product = Product.activos_con_cantidad.all

      respond_to do |format|
         format.html
         format.pdf do
            pdf = ReportPdf.new(@output_products)
            send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
         end
      end
   end


   def show
   end


   def new
      @output_product = OutputProduct.new
      @product = Product.activos
   end


   def create
      @output_product = OutputProduct.new(output_product_params)
      @output_product.product = params[:stock]
      respond_to do |format|
         if @output_product.save
            format.html { redirect_to @output_product, notice: 'Output product was successfully created.' }
            format.json { render :show, status: :created, location: @output_product }
         else
            format.html { render :new }
            format.json { render json: @output_product.errors, status: :unprocessable_entity }
         end
      end
   end

   private

   def set_output_product
      @output_product = OutputProduct.find(params[:id])
   end

   def output_product_params
      params.require(:output_product).permit(:stock, :product_id)
   end
end
