class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all
    @search = Coupon.new(params[:search])
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  def generate_pdf
    @coupon_to_pdf = params[:param1].to_i
    @sale_to_pdf = params[:param2].to_i
    @sale_old_to_pdf = params[:param3].to_i
    @coupon_amount = params[:param4].to_i
    @products_to_coupon = Hash.new("products to coupon")
    @hash_products_to_coupon = Hash.new("hash products to coupon")



    @detail_coupon = ItemCoupon.where(coupon_id: @coupon_to_pdf, sale_id: @sale_old_to_pdf)
    @detail_sale = Item.where(sale_id: @sale_to_pdf)
    item_old = Item.where(sale_id: @sale_old_to_pdf)
    product_different = Item.where('sale_id = ? and product_id NOT IN (select product_id from items where sale_id = ?)', @sale_old_to_pdf, @sale_to_pdf)

    item_old.each do |old|
      @detail_sale.each do |new|
        if old.product_id == new.product_id
          unless old.quantity == new.quantity
            substraction = old.quantity - new.quantity
            @products_to_coupon[new.product_id] = substraction
          end
        end
      end
    end

    product_different.each do |product|
      @products_to_coupon[product.product_id] = product.quantity
    end

    @products_to_coupon.each_with_index do |(key, value), index|
      products = Product.where(id: key).first
      @hash_products_to_coupon[products.name] = value
    end
    @user_do_coupon = current_user.name
    respond_to do |format|
      format.html
      format.pdf do
        pdf=CouponPdf.new(@detail_coupon,@detail_sale,@hash_products_to_coupon,@coupon_to_pdf,@sale_to_pdf,@coupon_amount,@user_do_coupon)
        send_data pdf.render, filename: 'cupon.pdf',disposition: "inline",type: 'application/pdf'
      end
    end
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  #Ingresa el codigo de una venta y generar el formulario con ese codigo
  def log_in_new_coupon
    @search = params[:search]
    sale = Sale.where(id: @search)
    sale.each do |sale|
      @sale_state = sale.state
    end
    respond_to do |format|
      if sale.ids.empty?
        format.html { redirect_to coupons_url, alert: 'La venta no existe.' }
        format.json { head :no_content }
      elsif @sale_state == "sinPagar"
        format.html { redirect_to coupons_url, alert: 'La venta no esta cancelada en su totalidad.' }
        format.json { head :no_content }
      elsif @sale_state == "anulada"
        format.html { redirect_to coupons_url, alert: 'La venta no existe.' }
        format.json { head :no_content }
      else
        sale.each do |s|
          @created_at=s.created_at
        end
        created_at_more_3 = @created_at + 3.days
        if Date.today.strftime('%F') <= created_at_more_3.strftime('%F')
          @detail_of_products = []
          @coupon = Coupon.new
          format.html { redirect_to '/coupons/'"#{@search}"'/detail_products' }
        else
           format.html { redirect_to coupons_url, alert: 'Se agoto la fecha limite para realizar el cambio.' }
           format.json { head :no_content }
        end
      end
    end
  end

  #Calcular el valor del bono
  def calculate_amount_coupon
    sales_id = params[:sale_id_coupon]
    products_ids = params[:info_product_id]
    products_quantity = params[:info_product_quantity]
    products_end_var = Hash.new("products")
    products_new_sale = Hash.new("products to new sale")
    products_coupon = Hash.new("products coupon")
    count = 0
    sale_amount = 0
    limit_date = Date.today + 3.days
    @sale_old = Sale.where(id: sales_id.to_i)
    @sale_old.each do |s|
      @sale_old_id = s.id
      @sale_old_customer= s.customer_id
      s.anulada!
    end

    for i  in 0..products_ids.length-1
      j=0
      begin
         j +=1
         products_end_var[products_ids[i]]=products_quantity[count]
         count +=1
      end until j > 0
    end

    products_end_var.each_with_index do |(key, value), index|
      if value.to_i >0
        products_coupon[key] = value
      else
          products_new_sale[key] = value
      end
    end
    respond_to do |format|
      #Se crea la nueva venta y los items
      unless products_new_sale.empty?
        @sale = Sale.new
        @sale.user_id = current_user.id
        @sale.discount = 0
        @sale.limit_date = limit_date.strftime('%F')
        @sale.save
        products_new_sale.each_with_index do |(key, value), index|
          id_product= key.to_i
          product = Product.where(id: id_product)
          product.each do |p|
            item = Item.where sale_id: sales_id.to_i, product_id: p.id
            item.each do |i|
              sale_amount += p.price * i.quantity
              @item_created = Item.create product_id: p.id, sale_id: @sale.id ,quantity: i.quantity
            end
          end
        end
        @sale.customer_id = @sale_old_customer
        @sale.amount = sale_amount
        @sale.total_amount = sale_amount
        @sale.save
      end

      #Se crea el coupon y los item_coupons
      unless products_coupon.empty?
        coupon_amount = 0
        @coupon = Coupon.new
        @coupon.amount = 1
        @coupon.save
        products_coupon.each_with_index do |(key, value), index|
          id_product= key.to_i
          value_product = value.to_i
          product = Product.where(id: id_product)
          product.each do |p|
            coupon_amount +=  p.price * value_product
            new_stock_product = p.stock + value_product
            p.update stock:  new_stock_product
            item = Item.where sale_id: sales_id.to_i, product_id: p.id
            item.each do |i|
              if i.quantity == value_product
                @new_item_coupon = ItemCoupon.create sale_id: @sale_old_id, coupon_id: @coupon.id, quantity: value_product
                @new_item_coupon.save
              else
                new_item_quantity = i.quantity - value_product
                #Validar que no puede ser negativo-------------------------------------->VALIDACION
                if new_item_quantity >= 0
                  if @sale.nil?
                    @sale = Sale.new
                    @sale.user_id = current_user.id
                    @sale.discount = 0
                    @sale.limit_date = limit_date.strftime('%F')
                    @sale_old.update state: "anulada"
                    @sale.save
                  end
                  @item_created = Item.create product_id: p.id, sale_id: @sale.id ,quantity: new_item_quantity
                  @new_item_coupon = ItemCoupon.create sale_id: @sale_old_id, coupon_id: @coupon.id , quantity: value_product
                  @new_item_coupon.save
                  @item_created.save
                  sale_amount += p.price * new_item_quantity
                else
                  unless @sale.nil?
                    Sale.last.destroy
                  end
                  Coupon.last.destroy
                  format.html { redirect_to coupons_url, alert: 'No se pudo realizar el cambio, la cantidad de productos a cambiar es inválida.' }
                  format.json { head :no_content }
                end
              end
            end
          end
        end
        @coupon.amount = coupon_amount
        @coupon.user_id = current_user.id
        @coupon.save
        unless @sale.nil?
          @sale.amount = sale_amount
          @sale.total_amount = sale_amount
          @sale.state = "pago"
          @sale.save
        end
      end
      if @sale.amount.nil?
        format.html{redirect_to url_for(:controller => :coupons,format: :pdf ,:action => :generate_pdf, :param1 => @coupon, :param2 => @sale, :param3 => @sale_old_id, :param4 => @coupon.amount)}
      else
        format.html { redirect_to coupons_url, alert: 'No se pudo realizar el cambio, no hay productos seleccionados.' }
      end
    end
  end

  #Redirecciona a la pagina de cambio
  def detail_products
    @sale_id = params[:id]
    customer_id = Sale.where(id: @sale_id)
    customer_id = customer_id.pluck(:customer_id)
    customers = Customer.where(id: customer_id[0].to_i)
    customers.each do |c|
      @customer = c.name
      @document = c.document
    end
    @products_sale = Item.where(sale_id: @sale_id)

  end


  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_url, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Estado
  def utilizado
    @coupon.utilizado!
    #Cambiar el redirect de acuerdo a la necesidad
    redirect_to sales_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:amount, :user_id, :state)
    end
end
