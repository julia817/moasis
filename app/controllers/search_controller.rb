class SearchController < ApplicationController
	def search_movies
		@search_term = params[:looking_for]
		if @search_term.blank?
			flash[:danger] = "検索キーワードが入力されていません"
			redirect_to root_path
		else
			@movies = Movie.search @search_term
			save_to_db unless @movies.blank?
		end
  	end

  	private
  		def save_to_db
  			@movies.each do |movie|
  				Movie.create movie unless Movie.exists?(id: movie["id"])
  			end
  		end


end
