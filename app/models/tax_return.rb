class TaxReturn < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Price
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
