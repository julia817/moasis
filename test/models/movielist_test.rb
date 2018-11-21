require 'test_helper'

class MovielistTest < ActiveSupport::TestCase
	# def setup
	# 	@user = users(:julia)
	# 	# @movie = movies(:avengers)
	# 	#@watched_movie = WatchedMovie.new(movie_id: @movie.id, user_id: @user.id)
	# 	@watched_movies = @user.movielists.build(listname: "watched")
	# end

	# test "should be valid" do
	# 	assert @watched_movies.valid?
	# end

	# test "user id should be present" do
	# 	@watched_movies.user_id = nil
	# 	assert_not @watched_movies.valid?
	# end

	# test "listname should be present" do
	# 	@watched_movies.listname = nil
	# 	assert_not @watched_movies.valid?
	# end

	# test " associated movielists should be destroyed" do
	# 	@user.save
	# 	@user.movielists.create(listname: "recommend")
	# 	assert_difference 'Movielist.count', -1 do
	# 		@user.destroy
	# 	end
	# end

	# test "order should be most recent first" do
	# 	assert_equal watchedmovies(:most_recent), WatchedMovie.first
	# end

end
