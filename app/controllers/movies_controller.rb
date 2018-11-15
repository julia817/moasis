class MoviesController < ApplicationController

	def show
		@movie = Movie.find(params[:id])
		@movie_credits = Movie.credits params[:id]
	end

end
