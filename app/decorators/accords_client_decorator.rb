class AccordsClientDecorator < Draper::Decorator
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
 			else
 					"nedefinovaný typ vlastnictví"
		end
 	end

 	def object_relationship
 		object.relationship
 	end
end
