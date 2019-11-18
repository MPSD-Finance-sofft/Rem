class Activity < ApplicationRecord
	belongs_to :user

	scope :for_user, -> (user_id) {where(user_id:  user_id)} 
	scope :start_created_at, -> (date) {where("activities.created_at > ?", date.to_date)}
	scope :end_created_at, -> (date) {where("activities.created_at < ?", date.to_date)}
	scope :user_id, -> (user_id) {where(user_id:  user_id)} 
	scope :objet, -> (objet) {where(objet:  objet)} 
	scope :object_id, -> (object_id) {where(object_id:  object_id)} 


end
