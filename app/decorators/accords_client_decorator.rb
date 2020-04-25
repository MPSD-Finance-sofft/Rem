class AccordsClientDecorator < ApplicationDecorator
  delegate_all

	def relationship
		relationship_to_text(object.relationship)
 	end

 	def select_relationship
 		AccordsClient.relationships.keys.map{|a| [relationship_to_text(a), a]}
 	end


 	def relationship_to_text(relationship)
 		case relationship
 			when 'owner'
 					"Majitel nemovitosti"
 			when 'applicant'
 					"Nájemce"
 			when 'tenant'
 					"Žadatel"
      when 'new_owner'
          "Nový vlastník"
 			else
 					"nedefinovaný typ vlastnictví"
		end
 	end

 	def object_relationship
 		object.relationship
 	end

 	def created_at
 		format_date_time object.created_at
 	end
end
