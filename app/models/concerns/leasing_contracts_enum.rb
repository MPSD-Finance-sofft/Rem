module LeasingContractsEnum extend ActiveSupport::Concern
	
	included do 
		enum state: [:entry,:actions, :debt,:added,:ended]
		enum kind: [:long,:from_reality, :prepaid]
	end
end