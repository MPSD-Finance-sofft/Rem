module ClientsEnum extend ActiveSupport::Concern
	
	included do 
		enum kind: [:person, :company]
	end
end