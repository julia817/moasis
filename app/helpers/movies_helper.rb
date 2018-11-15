module MoviesHelper
	def watched_check movie_id
		# if logged_in?
		# 	user = current_user
		# 	watched_list = user.movielists.find_by(listname: "watched")
		# 	unless watched_list.nil?
		# 		ListMovie.exists?(movielist_id: watched_list.id, movie_id: movie_id)
		# 	end
		# end
		check(movie_id, "watched")
	end

	def want_check movie_id
		# if logged_in?
		# 	user = current_user
		# 	want_list = user.movielists.find_by(listname: "want")
		# 	unless want_list.nil?
		# 		ListMovie.exists?(movielist_id: want_list.id, movie_id: movie_id)
		# 	end
		# end
		check(movie_id, "want")
	end

	def recommend_check movie_id
		# if logged_in?
		# 	user = current_user
		# 	rec_list = user.movielists.find_by(listname: "recommend")
		# 	unless rec_list.nil?
		# 		ListMovie.exists?(movielist_id: rec_list.id, movie_id: movie_id)
		# 	end
		# end
		check(movie_id, "recommend")
	end

	private
		def check(movie_id, listname)
			if logged_in?
				user = current_user
				@movielist = user.movielists.find_by(listname: listname)
				unless @movielist.nil?
					ListMovie.exists?(movielist_id: @movielist.id, movie_id: movie_id)
				end
			end
		end
end
