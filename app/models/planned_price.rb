class PlannedPrice < ApplicationRecord
	belongs_to :user, class_name: "User", foreign_key: 'user_id'
	belongs_to :accord
end
