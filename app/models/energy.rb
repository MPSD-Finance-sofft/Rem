class Energy < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include EnergiesEnum
	belongs_to :distributor
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
	scope :electricity, ->  {where(type: "Eletricity")}
end
