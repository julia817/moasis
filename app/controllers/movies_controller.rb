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
		@movie = Movie.find(params[:id])
		@movie_credits = Movie.credits params[:id]
		if logged_in?
			user = current_user
			unless user.movielists.find_by(listname: "watched").nil?
				@watched_check = ListMovie.exists?(movie_id:params[:id])
			end
			unless user.movielists.find_by(listname: "want").nil?
				@want_check = ListMovie.exists?(movie_id:params[:id])
			end
			unless user.movielists.find_by(listname: "recommend").nil?
				@recommend_check = ListMovie.exists?(movie_id:params[:id])
			end
		end
	end

end
