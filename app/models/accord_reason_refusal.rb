class AccordReasonRefusal < ApplicationRecord
	belongs_to :reason_refusal_type, foreign_key: 'reason_refusal_type_id', class_name: 'ReasonRefusalType'
	belongs_to :accord, foreign_key: 'accord_id', class_name: 'Accord'
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User' ,  required: false
end
