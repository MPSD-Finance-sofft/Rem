module AccordsEnum extend ActiveSupport::Concern
	
	included do 
		enum state: [:state_new, :state_eleboration,:in_terrain, :to_sign, :contract, :refuse, :dowload]
		enum kind: [:buyout, :auction, :insolvency_buyout]
	end
end