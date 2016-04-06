json.array!(@reserve_prices) do |reserve_price|
  json.extract! reserve_price, :id, :value, :time, :product_id
  json.url reserve_price_url(reserve_price, format: :json)
end
