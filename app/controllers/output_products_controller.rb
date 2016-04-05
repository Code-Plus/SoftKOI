class OutputProductsController < ApplicationController

   load_and_authorize_resource

   def index
      @output_products = OutputProduct.all

      respond_to do |format|
         format.html
         format.pdf do
            pdf = ReportPdf.new(@output_products)
            send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
         end
      end
   end


   def new
      #Obtener el producto que se selecciono para la baja
      @productx = Product.find(params[:product_id])
      @output_product = @productx.output_products.build
      @product = Product.activos
   end


   def create
      @output_product = Product.new
      @output_product = OutputProduct.new(output_product_params)
      @output_product.product = params[:stock]
      respond_to do |format|
         if @output_product.save
            format.html { redirect_to products_path, notice: 'La salida se ha registrado correctamente' }
            format.json { render :index, status: :created, location: @output_product }
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
