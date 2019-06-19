class UserDecorator < ApplicationDecorator
  delegate_all

 	def permission
 		object.permission.try(:kind)
 	end

 	def superior
 		object.superior.try(:all_name)
 	end

end
