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
end
