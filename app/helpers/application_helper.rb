module ApplicationHelper
	# ページタイトルを統一する
	def full_title(page_title='')
		base_title = "MOASIS"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	def profile_pic user
		if !user.pic_url.blank?
			user.pic_url
		elsif user.picture? == false
			"panda.png"
		else
			user.picture
		end
	end
end
