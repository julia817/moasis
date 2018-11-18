class SearchController < ApplicationController
	# enum search_type: { 映画: 0, 俳優: 1, ユーザ: 2 }

	def search_filter
	end

	def discover
		@search_type = params[:search_type]
		if @search_type == "movie"
			redirect_to :action => "search_movies", :looking_for => params[:looking_for]
		elsif @search_type == "people"
			redirect_to :action => "search_people", :looking_for => params[:looking_for]
		else
			redirect_to :action => "search_users", :looking_for => params[:looking_for]
		end
  end

	def search_movies
		@search_term = params[:looking_for]
		if @search_term.blank?
			flash[:danger] = "検索キーワードが入力されていません"
			redirect_to root_path
		else
			response = Movie.search(@search_term)
			@total_results = response["total_results"]
			unless @total_results == 0
				@total_pages = response["total_pages"]
				@movie_results = response["results"]
				if @total_pages>1
					@total_pages = @total_pages>20 ? 20 : @total_pages
					(2..@total_pages).each do |page|
						results = Movie.search(@search_term, page)["results"]
						(0...results.count).each do |i|
							@movie_results << results[i]
						end
					end
				end
			end
			@movie_results = Kaminari.paginate_array(@movie_results).page(params[:page]).per(20) unless @movie_results.blank?
		end
  end

  def search_people
  	@search_term = params[:looking_for]
		if @search_term.blank?
			flash[:danger] = "検索キーワードが入力されていません"
			redirect_to root_path
		else
			response = Movie.people(@search_term)
			@total_results = response["total_results"]
			unless @total_results == 0
				@total_pages = response["total_pages"]
				@people_results = response["results"]
				if @total_pages>1
					@total_pages = @total_pages>20 ? 20 : @total_pages
					(2..@total_pages).each do |page|
						results = Movie.people(@search_term, page)["results"]
						(0...results.count).each do |i|
							@people_results << results[i]
						end
					end
				end
			end
			@people_results = Kaminari.paginate_array(@people_results).page(params[:page]).per(20) unless @people_results.blank?
		end
	end

	def search_users
		@search_term = params[:looking_for]
		if @search_term.blank?
			flash[:danger] = "検索キーワードが入力されていません"
			redirect_to root_path
		else
			@users = User.search(@search_term).paginate(page: params[:page])
		end
	end

end
