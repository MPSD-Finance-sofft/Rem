module RecordOnLvEnum extend ActiveSupport::Concern
	
	included do 
		enum kind: [:burden, :execution, :hypothec,:insolvency_manager ,:unknown, :pledge]
	end
end