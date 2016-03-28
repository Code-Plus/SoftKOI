json.array!(@sales) do |sale|
  json.extract! sale, :id, :state, :final_date, :customer_id
  json.url sale_url(sale, format: :json)
end
