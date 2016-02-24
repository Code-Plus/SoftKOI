json.array!(@output_products) do |output_product|
  json.extract! output_product, :id, :stock, :product_id
  json.url output_product_url(output_product, format: :json)
end
