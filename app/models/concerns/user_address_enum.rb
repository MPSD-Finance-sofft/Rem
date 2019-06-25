module UserAddressEnum extend ActiveSupport::Concern
	
	included do 
		enum kind: [ :billing, :mailing, :permanent]
	end
end