class Payment < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Amount
	belongs_to :leasing_contract
end
