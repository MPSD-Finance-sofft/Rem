module LeasingContractsEnum extend ActiveSupport::Concern
	
	included do 
		enum state: [:entry,:actions, :debt,:added,:ended]
	end
end