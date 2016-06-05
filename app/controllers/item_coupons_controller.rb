class ItemCouponsController < ApplicationController


  private
    def item_coupon_params
      params.require(:item_coupon).permit(:sale_id, :coupon_id)
    end
end
