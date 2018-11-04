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
end
