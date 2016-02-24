# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do |i|
  	TypeProduct.create(name: "Type Product ##{i + 1}", description: "A product.", state: "disponible")
  	Category.create(name: "Category ##{i + 1}", description: "A category", state: "disponible", type_product_id: i + 1)
end

1.times do |u|
	User.create(document: "admin#{u}", encrypted_password: "123456789")
end