class SearchController < ApplicationController
	def search_movies
		@search_term = params[:looking_for]
		if @search_term.blank?
			flash[:danger] = "検索キーワードが入力されていません"
			redirect_to root_path
		else
			@total_results = Movie.search(@search_term)["total_results"]
			unless @total_results == 0
				@total_pages = Movie.search(@search_term)["total_pages"]
				@movie_results = Movie.search(@search_term)["results"]
				if @total_pages>1
					(2..@total_pages).each do |page|
						results = Movie.search(@search_term, page)["results"]
						(0...results.count).each do |i|
							@movie_results << results[i]
						end
					end
				end
				# save_to_db
			end
			@movie_results = Kaminari.paginate_array(@movie_results).page(params[:page]).per(20)
		end
  	end

  	private
  		def save_to_db
  			@movies.each do |movie|
  				Movie.create movie unless Movie.exists?(id: movie["id"])
  			end
  		end


end
