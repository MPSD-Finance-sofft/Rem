module LeasingContractsEnum extend ActiveSupport::Concern
	
	included do 
		enum state: [:entry,:action, :debt,:added,:ended]
	end
end