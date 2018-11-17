class Movie < ApplicationRecord
	include HTTParty

	has_many :list_movies
	has_many :movielists, through: :list_movies

	default_options.update(verify: false)
	default_params api_key: 'eb5a81372c8971c7a1dc86b855e863ed', language: 'ja-JP'
	format :json

	# search movies based on key words
	def self.search (term, page=1)
		base_uri 'https://api.themoviedb.org/3/search/movie'
		get("", query: { query: term, page: page })
	end

	def self.details id
		base_uri "https://api.themoviedb.org/3/movie/#{id}"
		get("", query: { append_to_response: 'credits' } )
	end

	def self.now_playing
		base_uri 'https://api.themoviedb.org/3/movie/now_playing'
		get("", query: { region: "JP" })["results"]
	end

	def new
	end

	def self.create movie
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
