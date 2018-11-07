class MoviesController < ApplicationController

	# include HTTParty

	# default_options.update(verify: false)
	# base_uri 'https://api.themoviedb.org/3/search/movie'
	# default_params api_key: 'eb5a81372c8971c7a1dc86b855e863ed'
	# format :json

	# def search term
	# 	get("", query: { query: term})["results"]
	# end

	def show
		@movie = Movie.find params[:id]
	end
end
