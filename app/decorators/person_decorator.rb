class PersonDecorator < ApplicationDecorator
  delegate_all


  	def marital_status
		marital_status_to_text(object.marital_status)
 	end

 	def select_marital_status
 		Person.marital_statuses.keys.map{|a| [marital_status_to_text(a), a]}
 	end


 	def marital_status_to_text(marital_status)
 		case marital_status
 			when 'divorced'
 					"Rozvedený / Rozvedená"
 			when 'married'
 					"Ženatý / Vdaná"
 			when 'widow'
 					"Vdoved / Vdova"
 			when 'single'
 					"Svodobný / Svobodná"
 			when 'mate'
 					"Druh / Družka"
 			else
 					"Neuvádí se"
		end
 	end

 	
end
