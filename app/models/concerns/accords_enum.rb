module AccordsEnum extend ActiveSupport::Concern
	
	included do 
		enum state: [:state_new, :state_eleboration, :to_sign, :contract, :refuse, :dowload]
		enum kind: [:buyout, :auction, :insolvency_buyout]
	end
end