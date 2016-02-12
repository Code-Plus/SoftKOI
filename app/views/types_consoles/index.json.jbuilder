json.array!(@types_consoles) do |types_console|
  json.extract! types_console, :id, :name
  json.url types_console_url(types_console, format: :json)
end
