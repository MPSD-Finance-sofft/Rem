class Terrain < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	after_save :set_state_accord
	belongs_to :accord
	belongs_to :user
	belongs_to :agent, foreign_key: 'agent_id', class_name: 'User' ,  required: false

	def set_state_accord
		self.accord.state = self.date_end_terrain.blank? ? :in_terrain : :state_eleboration
		self.accord.save
	end
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
