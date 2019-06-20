class CooperationDecorator < ApplicationDecorator
  delegate_all

 	def date_of_notice
		format_date(object.date_of_notice)
 	end

 	def type_of_notice
 		object.type_of_notice.try(:name)
 	end

 	def or_request
 		object.or_request.try(:all_name)
 	end

end
