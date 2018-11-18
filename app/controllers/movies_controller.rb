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
		@trailers = Movie.trailers(params[:id])
	end

	def show_person
		@person = Movie.person_details(params[:id])
		@person["also_known_as"].each do |n|
			if !(n =~ /(?:\p{Hiragana}|\p{Katakana}|[一-龠々])/).nil?
				@name = n
			end
		end
		@name = @name.nil? ? @person["name"] : @name
	end

end
