module SessionsHelper
	# log in the given user
	def log_in(user)
		session[:user_id] = user.id
	end

	# log out the current user
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	# return the current logged-in user (if any)
	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end

	# return true if the given user is the current user
	def current_user?(user)
		user == current_user
	end

	# return true if the user is logged in
	def logged_in?
		!current_user.nil?
	end

	# redirects to stored location (or to the default)
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default )
		session.delete(:forwarding_url)
	end

	# store the url trying to be accessed
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
end
