class MonthAdvenceDecorator < ApplicationDecorator
  delegate_all

   	def price 
  		format_number(object.price)
  	end

   	def date_due
  		format_date(object.date_due)
	end
  	
  	def date_of_payment
  		format_date(object.date_of_payment)
	end
  
end
