class RecordOnLv < ApplicationRecord
	include RecordOnLvEnum

 	def kind_to_s
 		record_on_lv_to_text(kind)
 	end

 	def record_on_lv_to_text(record_on_lv)
 		case record_on_lv
 			when "burden"
 				"Břemeno"
 			when "execution"
 				"Exekuce"
 			when 'hypothec'
 				"Hypotéka"
 			when 'insolvency_manager'
 				"Insolvenční manager"
 			when 'unknown'
 				"Neznámý"
 			when 'pledge'
 				"Zástava"
 			else
 				"nedefinovaný typ záznamu na lv"
		end
 	end
end
