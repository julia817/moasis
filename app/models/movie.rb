class Movie < ApplicationRecord
	include HTTParty

	default_options.update(verify: false)
	
	default_params api_key: 'eb5a81372c8971c7a1dc86b855e863ed', language: 'ja-JP'
	format :json

	def self.search term
		base_uri 'https://api.themoviedb.org/3/search/movie'
		get("", query: { query: term})["results"]
	end

	def show id
		# base_uri 'https://api.themoviedb.org/3/movie/#{id}'
		# get("", query: {})

	end

	def new
	end

	def self.create movie
		@movie = Movie.new(title:"#{movie["title"]}", date: "#{movie["release_date"]}", story: "#{movie["overview"]}")
		@movie.id = movie["id"]
		@movie.save
	end

	# private
	# 	def movie_params
	# 		params.require(:movie).permit :title, :date, :story
	# 	end
end
