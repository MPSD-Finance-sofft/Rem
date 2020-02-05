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

  def first_or_nil(array)
    return if array.blank?
    array.first
  end

  def last_or_nil(array)
    return if array.blank?
    array.last
  end
end