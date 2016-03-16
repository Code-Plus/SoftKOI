json.array!(@customers) do |customer|
  json.extract! customer, :id, :document, :firstname, :lastname, :phone, :cellphone, :birthday, :email, :state, :type_document_id
  json.url customer_url(customer, format: :json)
end
