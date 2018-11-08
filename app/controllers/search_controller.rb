class SearchController < ApplicationController
	def search_movies
		@search_term = params[:looking_for]
		if @search_term.nil?
			@movies = []
		else
			@movies = Movie.search @search_term
		end
		save_to_db
  	end

  	private
  		def save_to_db
  			@movies.each do |movie|
  				Movie.create movie unless Movie.exists?(id: movie["id"])
  			end
  		end
end
