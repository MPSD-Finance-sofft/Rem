  class Client < ApplicationRecord

  has_paper_trail ignore: [:updated_at]
  	

    belongs_to :permanent_address, class_name: 'Address', required: false
    belongs_to :contact_address, class_name: 'Address', required: false
  	has_many :client_mobile
    has_many :client_email
    has_many :mobile, through: :client_mobile
    has_many :email, through: :client_email
    has_one :accords_client
    
    accepts_nested_attributes_for :permanent_address,  reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :contact_address,  reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :client_mobile,  reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :client_email,  reject_if: :all_blank, allow_destroy: true

  	def full_name
  		"#{self.name} #{self.last_name}"
  	end

    def address
      return self.permanent_address if self.contact_address.blank?
      self.contact_address
    end 
end
