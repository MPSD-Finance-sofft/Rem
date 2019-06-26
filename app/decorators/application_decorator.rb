class ApplicationDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  	
  def format_date(date) 
  	date.strftime('%d.%m.%Y') unless date.blank?
  end

  def created_at
 		format_date(object.created_at)
	end

  def format_number(number)
    number_to_currency(number, unit: "Kč", separator: ",", delimiter: " ", format: "%n %u")
  end

  def format_date_time(date)
    date.strftime('%d.%m.%Y %I:%M%p') unless date.blank?
  end

end
