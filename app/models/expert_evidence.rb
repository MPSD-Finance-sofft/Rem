class ExpertEvidence < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::MarketPlace
	has_paper_trail ignore: [:updated_at, :id]
	belongs_to :user

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
