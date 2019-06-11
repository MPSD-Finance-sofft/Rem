class Energy < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include EnergiesEnum
	belongs_to :distributor
	validates :kind, :inclusion => {:in => kinds.keys}
end
