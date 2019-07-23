class Energy < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include EnergiesEnum
	belongs_to :distributor
	validates :kind, :inclusion => {:in => kinds.keys}
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
