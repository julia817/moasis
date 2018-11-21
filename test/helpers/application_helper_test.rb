require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, "MOASIS"
		assert_equal full_title("Help"), "Help | MOASIS"
		assert_equal full_title("About"), "About | MOASIS"
		assert_equal full_title("Contact"), "Contact | MOASIS"
	end
end