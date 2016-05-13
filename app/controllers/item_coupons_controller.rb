class ItemCouponsController < ApplicationController
  before_action :set_item_coupon, only: [:show, :edit, :update, :destroy]

  # GET /item_coupons
  # GET /item_coupons.json
  def index
    @item_coupons = ItemCoupon.all
  end

  # GET /item_coupons/1
  # GET /item_coupons/1.json
  def show
  end

  # GET /item_coupons/new
  def new
    @item_coupon = ItemCoupon.new
  end

  # GET /item_coupons/1/edit
  def edit
  end

  # POST /item_coupons
  # POST /item_coupons.json
  def create
    @item_coupon = ItemCoupon.new(item_coupon_params)

    respond_to do |format|
      if @item_coupon.save
        format.html { redirect_to @item_coupon, notice: 'Item coupon was successfully created.' }
        format.json { render :show, status: :created, location: @item_coupon }
      else
        format.html { render :new }
        format.json { render json: @item_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_coupons/1
  # PATCH/PUT /item_coupons/1.json
  def update
    respond_to do |format|
      if @item_coupon.update(item_coupon_params)
        format.html { redirect_to @item_coupon, notice: 'Item coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_coupon }
      else
        format.html { render :edit }
        format.json { render json: @item_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_coupons/1
  # DELETE /item_coupons/1.json
  def destroy
    @item_coupon.destroy
    respond_to do |format|
      format.html { redirect_to item_coupons_url, notice: 'Item coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_coupon
      @item_coupon = ItemCoupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_coupon_params
      params.require(:item_coupon).permit(:sale_id, :coupon_id)
    end
end
