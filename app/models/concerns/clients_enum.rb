module ClientsEnum extend ActiveSupport::Concern
	
	included do 
		enum kind: [:person]
	end
end