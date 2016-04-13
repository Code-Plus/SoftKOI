json.array!(@consoles) do |console|
  json.extract! console, :id, :name, :description, :serial, :state
  json.url console_url(console, format: :json)
end
