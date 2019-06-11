module NoteEnum extend ActiveSupport::Concern
	
	included do 
		enum color: [:red,:green, :yellow]
	end
end