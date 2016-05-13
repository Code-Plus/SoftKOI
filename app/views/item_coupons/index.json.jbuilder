json.array!(@item_coupons) do |item_coupon|
  json.extract! item_coupon, :id, :sale_id, :coupon_id
  json.url item_coupon_url(item_coupon, format: :json)
end
