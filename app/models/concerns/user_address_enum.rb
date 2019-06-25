module UserAddressEnum extend ActiveSupport::Concern
	
	included do 
		enum kind: [:permanent, :mailing, :billing]
	end
end