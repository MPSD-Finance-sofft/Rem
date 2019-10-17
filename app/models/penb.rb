class Penb < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Price
	include PenbEnum
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
