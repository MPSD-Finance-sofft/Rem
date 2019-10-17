class PenbDecorator < ApplicationDecorator
  delegate_all

  	def date_of_delivery_request
  		format_date(object.date_of_delivery_request)
  	end  

	def delivery_date
  		format_date(object.delivery_date)
  	end

	 def price 
  		format_number(object.price)
  	end

 	def object_energy_class
 		object.energy_class
 	end

 	def energy_class
		energy_class_to_text(object.energy_class)
 	end

 	def select_energy_class
 		Penb.energy_classes.keys.map{|a| [energy_class_to_text(a), a]}
 	end


 	def energy_class_to_text(energy_class)
 		case energy_class
 			when 'a'
				'A - Mimořádně úsporná'
 			when 'b'
				'B - Velmi úsporná'
 			when 'c'
 				'C - Úsporná'
 			when 'd'
				'D - Méně úsporná'
 			when 'e'
 				'E - Nehospodárná'
 			when 'f'
				'F - Velmi nehospodárná'
 			when 'g' 		
 				'G - Mimořádně nehospodárná'	
 			else
 				"nedefinovaný typ energie"
		end
 	end

end
