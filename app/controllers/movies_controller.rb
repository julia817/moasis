class MoviesController < ApplicationController

	def show
		@movie = Movie.find(params[:id])
		@movie_credits = Movie.credits params[:id]
		check
	end

	private
		def check
			if logged_in?
			user = current_user
			watched_list = user.movielists.find_by(listname: "watched")
			want_list = user.movielists.find_by(listname: "want")
			rec_list = user.movielists.find_by(listname: "recommend")
			unless watched_list.nil?
				@watched_check = ListMovie.exists?(movielist_id: watched_list.id, movie_id:params[:id])
			end
			unless want_list.nil?
				@want_check = ListMovie.exists?(movielist_id: want_list.id, movie_id:params[:id])
			end
			unless rec_list.nil?
				@recommend_check = ListMovie.exists?(movielist_id: rec_list.id, movie_id:params[:id])
			end
		end

end
