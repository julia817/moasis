class Movie < ApplicationRecord
	include HTTParty

	has_many :list_movies
	has_many :movielists, through: :list_movies

	default_options.update(verify: false)
	default_params api_key: 'eb5a81372c8971c7a1dc86b855e863ed'
	format :json

	# search movies based on key words
	def self.search (term, page=1)
		base_uri 'https://api.themoviedb.org/3/search/movie'
		get("", query: { query: term, page: page, language: 'ja-JP' })
	end

	def self.details id
		base_uri "https://api.themoviedb.org/3/movie/#{id}"
		get("", query: { language: 'ja-JP', append_to_response: 'credits' } )
	end

	def self.trailers id
		base_uri "https://api.themoviedb.org/3/movie/#{id}/videos"
		get("", query: {})["results"]
	end


	def self.now_playing(page=1)
		base_uri 'https://api.themoviedb.org/3/movie/now_playing'
		get("", query: { page: page, language: 'ja-JP', region: "JP" })["results"]
	end

	def self.genre_list (id, page=1)
		base_uri 'https://api.themoviedb.org/3/discover/movie'
		get("", query: { page: page, language: 'ja-JP', with_genres: id })
	end

	def self.year_list (year, page=1)
		base_uri 'https://api.themoviedb.org/3/discover/movie'
		get("", query: { page: page, language: 'ja-JP', primary_release_year: year })
	end

	# def self.years90s_list (lower, upper, page=1)
	# 	base_uri 'https://api.themoviedb.org/3/discover/movie'
	# 	get("", query: { page: page, language: 'ja-JP', primary_release_date.gte: lower, primary_release_date.lte: upper })
	# end

	# def self.oldyears_list (upper, page=1)
	# 	base_uri 'https://api.themoviedb.org/3/discover/movie'
	# 	get("", query: { page: page, language: 'ja-JP', primary_release_date.lte: upper })
	# end

	def self.people(term, page=1)
		base_uri 'https://api.themoviedb.org/3/search/person'
		get("", query: { query: term, page: page, language: 'ja-JP' })
	end

	def self.person_details id
		base_uri "https://api.themoviedb.org/3/person/#{id}"
		get("", query: { language: 'ja-JP', append_to_response: 'movie_credits' })
	end

	def new
	end

	def self.get_score id
		movie = Movie.find(id)
		(movie.rec_num.quo(movie.watched_num).to_f*100).round(1)
	end

	def self.add id
		movie = Movie.new(watched_num: 0, rec_num: 0)
		movie.id = id
		movie.save
	end


	private
		


	# 	def movie_params
	# 		params.require(:movie).permit :title, :date, :story
	# 	end
end
