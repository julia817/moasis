class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:destroy]

	# show all users
	def index
		@users = User.paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "アカウントを作成しました。　ムアシスへようこそ！"
			Movielist.create(user_id: @user.id, listname: "watched")
			Movielist.create(user_id: @user.id, listname: "want")
			Movielist.create(user_id: @user.id, listname: "recommend")
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "プロフィールを更新しました！"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "ユーザを削除しました！"
		redirect_to users_url
	end

	# relationships

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	# movies related

	def watched
		@watched = listup("watched")
	end

	def want
		@want = listup("want")
	end

	def recommend
		@recommend = listup("recommend")
	end	


	private
		# strong params to restrict actions
		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation, :picture)
		end

		def listup listname
			@user = User.find(params[:id])
			@movielist = @user.movielists.find_by(listname: "#{listname}")
			unless @movielist.nil?
				ListMovie.where(movielist_id: @movielist.id)
			end
		end

		# before filters

		# confirm a logged-in user
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "ログインしてください。"
				redirect_to login_path
			end
		end

		# confirm the correct user
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		# confirm an admin user
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
