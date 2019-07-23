module NoteEnum extend ActiveSupport::Concern
	
	included do 
		enum permission: [:agent, :manager, :user]
	end
end