json.array!(@sales) do |sale|
  json.extract! sale, :id, :state, :amount, :total_amount, :remaining, :discount, :limit_date, :user_id, :comment, :customer_id
  json.url sale_url(sale, format: :json)
end
