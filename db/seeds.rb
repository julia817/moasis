# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(username: "julia",
			 email: "julia@example.com",
			 password: "password",
			 password_confirmation: "password",
			 admin: true)

25.times do |n|
	username = Faker::StarWars.unique.character.gsub(" ", "")
	email = "#{username}@starwars.org"
	password = "password"
	picture = Faker::Avatar.image
	User.create!(username: username,
				 email: email,
				 password: password,
				 password_confirmation: password,
				 picture: picture)
end
25.times do |n|
	username = Faker::HarryPotter.unique.character.gsub(" ", "")
	email = "#{username}@harrypotter.org"
	password = "password"
	picture = Faker::Avatar.image
	User.create!(username: username,
				 email: email,
				 password: password,
				 password_confirmation: password,
				 picture: picture)
end
25.times do |n|
	username = Faker::Pokemon.unique.name.gsub(" ", "")
	email = "#{username}@pokemon.org"
	password = "password"
	picture = Faker::Avatar.image
	User.create!(username: username,
				 email: email,
				 password: password,
				 password_confirmation: password,
				 picture: picture)
end
25.times do |n|
	username = Faker::Superhero.unique.name.gsub(" ", "")
	email = "#{username}@superhero.org"
	password = "password"
	picture = Faker::Avatar.image
	User.create!(username: username,
				 email: email,
				 password: password,
				 password_confirmation: password,
				 picture: picture)
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }