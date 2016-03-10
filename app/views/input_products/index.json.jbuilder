json.array!(@input_products) do |input_product|
  json.extract! input_product, :id, :stock, :product_id
  json.url input_product_url(input_product, format: :json)
end
