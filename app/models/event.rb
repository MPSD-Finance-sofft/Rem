class Event < ApplicationRecord
	validates :title, presence: true
  	attr_accessor :date_range

  	belongs_to :creator, class_name: "User", foreign_key: 'creator_id'
    belongs_to :user, class_name: "User", foreign_key: 'user_id'

  	def all_day_event?
    	self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  	end

  	def event_text_with_accord(accord_id)
  		#self.title = self.title + "<a href='/accords/#{accord_id}'>Žádost</a>"
  	end
	scope :for_user, -> (user_id) {where(user_id:  user_id)} 
  scope :done, -> (done) {where(done:  done)} 
  scope :title, -> (title) {where(title:  title)} 
  scope :creator, -> (creator_id) {where(creator:  creator_id)} 
  scope :end_date, -> (end_date) {where('end <= ?', end_date.to_date + 1.day)} 
  scope :start_date, -> (start_date) {where('start >= ?', start_date.to_date+ 1.day)} 
end
