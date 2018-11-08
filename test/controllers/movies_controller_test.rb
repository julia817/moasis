require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
	test "should get show page" do
		get show_path
		assert_response :success
	end
end
