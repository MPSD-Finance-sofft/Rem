class UserAddressDecorator < ApplicationDecorator
  delegate_all

  def kind
		kind_to_text(object.kind)
 	end

 	def select_kind
 		UserAddress.kinds.keys.map{|a| [kind_to_text(a), a]}
 	end


 	def kind_to_text(kind)
 		case kind
 			when 'permanent'
 					"Trvalého bydliště"
 			when 'mailing'
 					"Korespondenční"
 			when 'billing'
 					"Fakturační"
 			else
 					"nedefinovaný typ addresy"
		end
 	end

 	def object_kind
 		object.kind
 	end
end