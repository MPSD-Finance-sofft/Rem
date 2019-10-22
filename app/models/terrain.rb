class Terrain < ApplicationRecord
	belongs_to :accord
	belongs_to :user
	belongs_to :agent, foreign_key: 'agent_id', class_name: 'User' ,  required: false

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
