class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# log in & redirect to the show page
  		log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_back_or user
  	else
  		# error message
  		flash.now[:danger] = 'メールアドレスとパスワードの組み合わせは有効ではありません'
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
