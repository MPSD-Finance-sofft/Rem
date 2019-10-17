class FlatAdmistration < ApplicationRecord
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end
