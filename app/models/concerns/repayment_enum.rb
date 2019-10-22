module RepaymentEnum extend ActiveSupport::Concern
	
	included do 
		enum paid: [:paid,:not_paid, :debt]
	end
end