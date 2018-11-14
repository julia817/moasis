class ListMoviesController < ApplicationController
	before_action :logged_in_user, only: [:create, :create_watched, :create_want, :create_recommend]

	# in order to show all three buttons on
	def create
	end
	
	# add watched movie to the database
	def create_watched
		@user = current_user
		if @user.movielists.find_by(listname: "watched").nil?
			@list = @user.movielists.create(listname: "watched")
		else
			@list = @user.movielists.find_by(listname: "watched")
		end
		@add_movie = ListMovie.new(movielist_id: @list.id, movie_id: params[:movie_id])
		if @add_movie.save
			flash[:success] = "リストに追加しました"
			redirect_to :controller => "users", :action => "watched"
		else
			flash[:danger] = "追加失敗しました"
			redirect_to :back
		end
	end

	# add the movie that user wants to watch to the database
	def create_want
		@user = current_user
		if @user.movielists.find_by(listname: "want").nil?
			@list = @user.movielists.create(listname: "want")
		else
			@list = @user.movielists.find_by(listname: "want")
		end
		@add_movie = ListMovie.new(movielist_id: @list.id, movie_id: params[:movie_id])
		if @add_movie.save
			flash[:success] = "リストに追加しました"
			redirect_to :controller => "users", :action => "want"
		else
			flash[:danger] = "追加失敗しました"
			redirect_to :back
		end
	end

	# add recommended movie to the database
	def create_recommend
		@user = current_user
		if @user.movielists.find_by(listname: "recommend").nil?
			@list = @user.movielists.create(listname: "recommend")
		else
			@list = @user.movielists.find_by(listname: "recommend")
		end
		@add_movie = ListMovie.new(movielist_id: @list.id, movie_id: params[:movie_id])
		if @add_movie.save
			flash[:success] = "リストに追加しました"
			redirect_to :controller => "users", :action => "recommend"
		else
			flash[:danger] = "追加失敗しました"
			redirect_to :back
		end
	end


	private
		# confirm a logged-in user
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "ログインしてください。"
				redirect_to login_path
			end
		end

		# def movie_params
		# 	params.permit(:movielist_id, :movie_id)
		# end
end
