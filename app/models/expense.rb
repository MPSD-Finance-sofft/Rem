class Expense < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Commitment
	belongs_to :expense_type
  belongs_to :accord
	has_paper_trail ignore: [:updated_at]

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
