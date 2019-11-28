module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def check(check)
  	if check
		'<i class="fa fa-check" style="color:green"></i>'.html_safe
	else
		'<i class="fa fa-times" style="color:red"></i>'.html_safe
	end
  end
end