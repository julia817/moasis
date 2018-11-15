require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:julia)
		@another = users(:another)
	end

	test "should get new" do
		get signup_path
		assert_response :success
	end

	test "should redirect edit when not logged in" do
		get edit_user_path(@user)
		assert_not flash.empty?
		assert_redirected_to login_path
	end

	test "should redirect update when not logged in" do
		patch user_path(@user), params: { user: { username: @user.username, email: @user.email } }
		assert_not flash.empty?
		assert_redirected_to login_path
	end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@another)
		get edit_user_path(@user)
		assert flash.empty?
		assert_redirected_to root_path
	end

	test "should redirect update when logged in as wrong user" do
		log_in_as(@another)
		patch user_path(@user), params: { user: { username: @user.username, email: @user.email } }
		assert flash.empty?
		assert_redirected_to root_path
	end

	test "should redirect index when not logged in" do
	    get users_path
	    assert_redirected_to login_path
  	end

  	test "should not allow the admin attribute to be edited via the web" do
  		log_in_as(@another)
  		assert_not @another.admin?
  		patch user_path(@another), params: { user: { password: '123abc',
  													 password_confirmation: '123abc',
  													 admin: true } }
  		assert_not @another.reload.admin?
  	end

  	test "should redirect destroy when not logged in" do
  		assert_no_difference 'User.count' do
  			delete user_path(@user)
  		end
  		assert_redirected_to login_path
  	end

  	test "should redirect destroy when logged in as a non-admin" do
  		log_in_as(@another)
  		assert_no_difference 'User.count' do
  			delete user_path(@user)
  		end
  		assert_redirected_to root_path
  	end

  	test "should redirect following when not logged in" do
  		get following_user_path(@user)
  		assert_redirected_to login_path
  	end

  	test "should redirect followers when not logged in" do
  		get followers_user_path(@user)
  		assert_redirected_to login_path
  	end
end
