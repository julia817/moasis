require 'test_helper'

class ListMovieTest < ActiveSupport::TestCase
	def setup
		@user = users(:julia)
		@movie = movies(:avengers)
		#@watched_movie = WatchedMovie.new(movie_id: @movie.id, user_id: @user.id)
		@watched_movies = @user.movielists.build(listname: "watched")
		@movie_added = ListMovie.create(movielist: @watched_movies, movie: @movie)
	end

	test "should be valid" do
		assert @movie_added.valid?
	end

	test "movielist id is should be present" do
		@movie_added.movielist_id = nil
		assert_not @movie_added.valid?
	end

	test "movie id should be present" do
		@movie_added.movie_id = nil
		assert_not @movie_added.valid?
	end

	# test "order should be most recent first" do
	# 	assert_equal list_movies(:most_recent), ListMovie.first
	# end
end
