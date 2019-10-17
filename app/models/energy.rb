class Energy < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Price
	include EnergiesEnum
	belongs_to :distributor
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
