class UserDocumentDecorator < ApplicationDecorator
	delegate_all
	def document_type_to_s
		object.document_type.try(:description)
	end

end