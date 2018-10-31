require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, "ムアシス"
		assert_equal full_title("Help"), "Help | ムアシス"
		assert_equal full_title("About"), "About | ムアシス"
		assert_equal full_title("Contact"), "Contact | ムアシス"
	end
end