
class UserDecorator < ApplicationDecorator
  delegate_all

 	def permission
 		object.permission.try(:kind)
 	end

 	def superior
 		object.superior.try(:all_name)
 	end

 	def mobile
 		object.mobile.last.try(:phone_number)
 	end

 	def object_superior
 		object.superior
 	end

 	def date_of_cooperation
 		format_date(object.date_of_cooperation)
 	end
end
