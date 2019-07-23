module NoteEnum extend ActiveSupport::Concern
	
	included do 
		enum color: [:red,:green, :yellow]
		enum permission: [:agent, :manager, :user]
	end
end