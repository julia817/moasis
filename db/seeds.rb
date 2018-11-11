# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(username: "julia",
			 email: "julia@example.com",
			 password: "password",
			 password_confirmation: "password",
			 admin: true)

100.times do |n|
	username = Faker::Pokemon.unique.name.downcase
	email = "#{username}@pokemon.com"
	password = "password"
	User.create!(username: username,
				 email: email,
				 password: password,
				 password_confirmation: password)
end