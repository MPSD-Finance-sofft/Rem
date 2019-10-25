class Payment < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Amount
	belongs_to :leasing_contract
end
