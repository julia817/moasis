# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create(username: "julia",
					  email: "julia@example.com",
					  password: "password",
					  password_confirmation: "password",
					  admin: true)

30.times do |n|
	username = Faker::StarWars.unique.character.gsub!(/[^0-9A-Za-z]/, '')
	if username.blank?
		next
	else
		email = "#{username}@starwars.org"
		password = "password"
		User.create(username: username,
							  email: email,
							  password: password,
							  password_confirmation: password)
	end
end
30.times do |n|
	username = Faker::HarryPotter.unique.character.gsub!(/[^0-9A-Za-z]/, '')
	if username.blank?
		next
	else
		email = "#{username}@harrypotter.org"
		password = "password"
		User.create(username: username,
					 		  email: email,
							  password: password,
							  password_confirmation: password)
	end
end

30.times do |n|
	username = Faker::Pokemon.unique.name.gsub!(/[^0-9A-Za-z]/, '')
	if username.blank?
		next
	else
		email = "#{username}@pokemon.org"
		password = "password"
		User.create(username: username,
							  email: email,
							  password: password,
							  password_confirmation: password)
	end
end

30.times do |n|
	username = Faker::Superhero.unique.name.gsub!(/[^0-9A-Za-z]/, '')
	if username.blank?
		next
	else
		email = "#{username}@superhero.org"
		password = "password"
		User.create(username: username,
							  email: email,
							  password: password,
							  password_confirmation: password)
	end
end

# Create movielists
User.all.each do |user|
	Movielist.create(user_id: user.id, listname: "watched")
	Movielist.create(user_id: user.id, listname: "want")
	Movielist.create(user_id: user.id, listname: "recommend")
end

# Following relationships
users = User.all
user = users.first
following = users.sample(67)
followers = users.sample(49)
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }