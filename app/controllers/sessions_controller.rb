class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    raise env['omniauth.auth'].to_yaml
    # if auth.present?
    #   user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    #   session[:user_id] = user.id
    #   redirect_back_or user
    # else
    # 	user = User.find_by(email: params[:session][:email].downcase)
    # 	if user && user.authenticate(params[:session][:password])
    # 		# log in & redirect to the show page
    # 		log_in user
    #     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    # 		redirect_back_or user
    # 	else
    # 		# error message
    # 		flash.now[:danger] = 'メールアドレスとパスワードの組み合わせは有効ではありません'
    # 		render 'new'
    # 	end
    # end
  end

  def destroy
  	log_out if logged_in?
    flash[:info] = 'ログアウトしました'
  	redirect_to root_url
  end
end
