class MoviesController < ApplicationController

	def show
		# @movie = Movie.find(params[:id])
		# @movie_credits = Movie.credits params[:id]
		@movie = Movie.details(params[:id])
		if @movie["credits"]["cast"].count > 5
			@cast_range = 5
		else
			@cast_range = @movie["credits"]["cast"].count
		end
	end

end
