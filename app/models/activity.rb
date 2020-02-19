class Activity < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	belongs_to :user
	belongs_to :true_user, foreign_key: 'true_user_id', class_name: 'User',  required: false

	def self.duplicate
		Activity.all.group_by(&:filter).select{|k,v| v.size > 1}
	end

	def self.delete_duplicate
		list = []
		Activity::duplicate.each do |duplicate|
			data = duplicate.last
			activity_ids = data.map(&:id)
			activity_ids.pop
			list << activity_ids
			Activity.where(id: activity_ids).delete_all
		end
		SchedulerLog.create(kind: 'Activity', list: list) unless list.blank?
	end

	def filter
		self.created_at.day.to_s + self.created_at.hour.to_s + self.created_at.year.to_s + self.user_id.to_s + self.object_id.to_s + self.objet.to_s
	end

	scope :for_user, -> (user_id) {where(user_id:  user_id)} 
	scope :start_created_at, -> (date) {where("activities.created_at > ?", date.to_date)}
	scope :end_created_at, -> (date) {where("activities.created_at < ?", date.to_date)}
	scope :user_id, -> (user_id) {where(user_id:  user_id)} 
	scope :objet, -> (objet) {where(objet:  objet)} 
	scope :object_id, -> (object_id) {where(object_id:  object_id)} 


end
