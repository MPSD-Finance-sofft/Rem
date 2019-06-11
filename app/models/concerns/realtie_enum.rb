module RealtieEnum extend ActiveSupport::Concern
	
	included do 
		enum type_ownership: [:part,:exclusiv, :sjm]
	end
end