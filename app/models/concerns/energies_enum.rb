module EnergiesEnum extend ActiveSupport::Concern
	
	included do 
		enum kind: [:electricity, :gas, :water]
	end
end