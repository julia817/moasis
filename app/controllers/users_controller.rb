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

	def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    if provider == 'twitter'
    	name = auth[:info][:nickname]
    else
    	name = auth[:info][:name]
    end
    # email = auth[:info][:email]
    image = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
    	user.provider = provider
    	user.uid = uid
    	# user.email = email
      user.username = name
      user.pic_url = image
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
		list = listup("watched")
		paginate_list(list)
	end

	def want
		list = listup("want")
		paginate_list(list)
	end

	def recommend
		list = listup("recommend")
		paginate_list(list)
		# current user's watched list
		@my_watched = User.my_watched(@movielist.id, params[:my_id])
	end	

	
	def my_watched
		@list = listup("recommend")
		@count = @list.count
		@my_watched = User.my_watched(@movielist.id, params[:my_id])
	end

	def my_unwatched
		@list = listup("recommend")
		@count = @list.count
		@my_unwatched = User.my_unwatched(@movielist.id, params[:my_id])
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

		def paginate_list list
			@count = list.count
			unless list.blank?
				@list = Array.new
				list.each do |movie|
					@list << movie
				end
				@list = Kaminari.paginate_array(@list).page(params[:page]).per(20)
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
