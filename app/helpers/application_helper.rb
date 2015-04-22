module ApplicationHelper
	#根据所在页面返回完整标题
	def full_title(page_title = '')
		base_title = "爱吐槽"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
end
