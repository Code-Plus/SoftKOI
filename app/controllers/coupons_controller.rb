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
    respond_to do |format|
      if sale.ids.empty?
          format.html { redirect_to coupons_url, alert: 'La venta no existe.' }
          format.json { head :no_content }
      else
        @detail_of_products = []
        @coupon = Coupon.new
        format.html { redirect_to '/coupons/'"#{@search}"'/detail_products' }
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
    sale_old = Sale.where(id: sales_id.to_i)
    sale_old.each do |s|
      @sale_old_id = s.id
      @sale_old_customer= s.customer_id
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

        #@sale_old.update state: "anulada"
        @sale.customer_id = @sale_old_customer
        @sale.amount = sale_amount
        @sale.total_amount = sale_amount
        @sale.save
      end

      #Se crea el coupon y los item_coupons
      unless products_coupon.empty?
        coupon_amount = 0
        coupon = Coupon.new
        coupon.amount = 1
        coupon.save
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
                @new_item_coupon = ItemCoupon.create sale_id: @sale_old_id, coupon_id: coupon.id, quantity: value_product
                @new_item_coupon.save
              else
                new_item_quantity = i.quantity - value_product
                #Validar que no puede ser negativo-------------------------------------->VALIDACION
                unless @sale.nil?
                  @sale = Sale.new
                  @sale.user_id = current_user.id
                  @sale.discount = 0
                  @sale.limit_date = limit_date.strftime('%F')
                  #@sale_old.update state: "anulada"
                  @sale.save
                end
                @item_created = Item.create product_id: p.id, product_id: p.id ,quantity: new_item_quantitys
                @new_item_coupon = ItemCoupon.create sale_id: @sale_old_id, coupon_id: coupon.id , quantity: value_product
                @new_item_coupon.save
                @item_created.save
                sale_amount += p.price * new_item_quantitys
              end
            end
          end
        end
        coupon.amount = coupon_amount
        coupon.user_id = current_user.id
        coupon.save
        @sale.amount = sale_amount
        @sale.total_amount = sale_amount
        @sale.save

      end


      format.html { redirect_to coupons_url, notice: 'Cambio realizado con exito.' }
      format.json { head :no_content }
    end

  end

  #Redirecciona a la pagina de cambio
  def detail_products
    @sale_id = params[:id]
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:amount)
    end
end
