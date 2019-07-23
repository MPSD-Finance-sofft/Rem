class Expense < ApplicationRecord
	belongs_to :expense_type 
	has_paper_trail ignore: [:updated_at]

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
