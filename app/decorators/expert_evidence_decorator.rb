class ExpertEvidenceDecorator < ApplicationDecorator
  delegate_all

  	def user	
  		object.user.try(:username)
  	end

  	def of_date
 		format_date(object.of_date)
	end
	
  	def delivery_date
 		format_date(object.delivery_date)
	end

	def market_price
		format_number object.market_price
	end
end
