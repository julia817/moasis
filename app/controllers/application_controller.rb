class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # confirm a logged-in user
  def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "ログインしてください。"
			redirect_to login_path
		end
	end
end
