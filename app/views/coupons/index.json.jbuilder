json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :amount, :integer
  json.url coupon_url(coupon, format: :json)
end
