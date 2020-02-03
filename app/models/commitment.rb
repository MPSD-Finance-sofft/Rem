class Commitment < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Commitment
	has_paper_trail ignore: [:updated_at]
	belongs_to :commitment_type

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
	scope :for_type, -> (commitment_type_id) {where(commitment_type_id: commitment_type_id)}
end
