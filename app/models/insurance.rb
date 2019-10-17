class Insurance < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Insurance
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
