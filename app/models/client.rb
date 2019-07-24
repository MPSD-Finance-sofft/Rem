  class Client < ApplicationRecord
	include ClientsEnum
  has_paper_trail ignore: [:updated_at]
  	
  	validates :kind, :inclusion => {:in => kinds.keys}

  	belongs_to :person, foreign_key: 'object_id'
    belongs_to :permanent_address, class_name: 'Address', required: false
    belongs_to :contact_address, class_name: 'Address', required: false
  	
  	accepts_nested_attributes_for :person,  reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :permanent_address,  reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :contact_address,  reject_if: :all_blank, allow_destroy: true
  	has_one :accords_client

  	def full_name
  		"#{person.name} #{person.last_name}"
  	end
end
