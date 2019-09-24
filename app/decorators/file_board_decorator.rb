class FileBoardDecorator < ApplicationDecorator
  delegate_all

  def end
  	format_date object.end
  end


  def start
  	format_date object.start
  end

end
