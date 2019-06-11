class ExpertEvidence < ApplicationRecord
	has_paper_trail ignore: [:updated_at, :id]
	belongs_to :user
end
