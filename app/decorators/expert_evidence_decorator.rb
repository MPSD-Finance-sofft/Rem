class ExpertEvidenceDecorator < ApplicationDecorator
  delegate_all

  	def user	
  		object.user.try(:username)
  	end

  	def of_date
 		format_date(object.of_date)
	end
end
