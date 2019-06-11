class Expense < ApplicationRecord
	belongs_to :expense_type 
	has_paper_trail ignore: [:updated_at]
end
