# frozen_string_literal: true

class Event < ApplicationRecord
  attr_accessor :date_range

  validates :title, presence: true

  belongs_to :creator, class_name: "User"
  belongs_to :user, class_name: "User"

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

  def event_text_with_accord(accord_id)
    # self.title = self.title + "<a href='/accords/#{accord_id}'>Žádost</a>"
  end

  def self.create_birthday
    User.can_sign_in.manager_and_agents_and_tipster.where.not(birthdate: nil).find_each do |user|
      date = Date.new(Date.today.year, user.birthdate.month, user.birthdate.day)

      if Event.where(title: "Narozeniny").where(creator_id: user.id).where(start: date.beginning_of_day..date.end_of_day).blank?
        Event.create(user_id: 1, title: "Narozeniny", creator_id: user.id, start: date, end: date, text: "Narozeniny #{user.all_name}", color: "#f5f542")
        Event.create(user_id: 18720, title: "Narozeniny", creator_id: user.id, start: date, end: date, text: "Narozeniny #{user.all_name}", color: "#f5f542")
        Event.create(user_id: 31523, title: "Narozeniny", creator_id: user.id, start: date, end: date, text: "Narozeniny #{user.all_name}", color: "#f5f542")
      end
    end
  end

  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :subordinates_events, ->(user) { where(user_id: [User.where(superior_id: user.id).pluck(:id)]) }
  scope :done, ->(done) { where(done: done) }
  scope :title, ->(title) { where(title: title) }
  scope :creator, ->(creator_id) { where(creator: creator_id) }
  scope :end_date, ->(end_date) { where('end <= ?', end_date.to_date + 1.day) }
  scope :start_date, ->(start_date) { where('start >= ?', start_date.to_date+ 1.day) }
end
