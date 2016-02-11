json.array!(@types_clothings) do |types_clothing|
  json.extract! types_clothing, :id, :name
  json.url types_clothing_url(types_clothing, format: :json)
end
