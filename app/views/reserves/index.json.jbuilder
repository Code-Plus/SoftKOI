json.array!(@reserves) do |reserf|
  json.extract! reserf, :id, :customer, :product_id, :date, :start_time, :end_time, :state, :price_reserve_id
  json.url reserf_url(reserf, format: :json)
end
