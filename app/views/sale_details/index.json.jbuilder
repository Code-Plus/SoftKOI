json.array!(@sale_details) do |sale_detail|
  json.extract! sale_detail, :id, :discount, :price, :product_id
  json.url sale_detail_url(sale_detail, format: :json)
end
