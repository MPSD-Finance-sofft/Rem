class Commitment < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	belongs_to :commitment_type
end
