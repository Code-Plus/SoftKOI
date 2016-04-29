json.array!(@payments) do |payment|
  json.extract! payment, :id, :amount, :penalty, :sale_id
  json.url payment_url(payment, format: :json)
end
