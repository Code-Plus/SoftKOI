json.array! @notifications do |notification|
  json.id notification.id
  json.notifiable do
    json.type "El #{notification.trackable_type.downcase} "
  end
  json.trackable notification.trackable.name
  json.key notification.key
end
