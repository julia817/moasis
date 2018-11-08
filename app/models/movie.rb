class Movie < ApplicationRecord
	include HTTParty

	default_options.update(verify: false)
	
	default_params api_key: 'eb5a81372c8971c7a1dc86b855e863ed', language: 'ja-JP'
	format :json

	def self.search term
		base_uri 'https://api.themoviedb.org/3/search/movie'
		get("", query: { query: term})["results"]
	end

	def self.credits id
		base_uri "https://api.themoviedb.org/3/movie/#{id}/credits"
		get("", query: {})
	end

	def new
	end

	def self.create movie
		# ge = Array.new
		# movie["genres"].each do |g|
		# 	ge.push(g["name"])
		# end
		# genres = ge.join('、')
		@movie = Movie.new(title:"#{movie["title"]}",
						   date: "#{movie["release_date"]}",
						   story: "#{movie["overview"]}",
						   posterpath: "https://image.tmdb.org/t/p/original#{movie["poster_path"]}",
						   pic_path: "https://image.tmdb.org/t/p/original#{movie["backdrop_path"]}",
						   genre: movie["genre_ids"].join('、'),
						   original_title: "#{movie["original_title"]}"
						   )
		@movie.id = movie["id"]
		@movie.save
	end

	private
		


	# 	def movie_params
	# 		params.require(:movie).permit :title, :date, :story
	# 	end
end
