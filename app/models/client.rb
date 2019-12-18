class Client < ApplicationRecord
  has_paper_trail ignore: [:updated_at]  	

  DIFF_ATTRIBUTES = ["permanent_address_id", "contact_address_id", "name", "type", "identity_card_number", "personal_identification_number", "data_box", "last_name", "relation_ship"]

  belongs_to :permanent_address, class_name: 'Address', required: false
  belongs_to :contact_address, class_name: 'Address', required: false
	has_many :client_mobile
  has_many :client_email
  has_many :mobile, through: :client_mobile
  has_many :email, through: :client_email
  has_many :accords_client
  has_many :leasing_contract_clients
  
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

  def joins_clients(second_client)
    self.update self.diff_without_nil(second_client, DIFF_ATTRIBUTES)
    second_client.accords_client.each do |ac|
      ac.client_id = self.id
      ac.save 
    end 
    second_client.leasing_contract_clients.each do |ac|
      ac.client_id = self.id
      ac.save 
    end 
    second_client.client_mobile.each do |ac|
      ac.client_id = self.id
      ac.save 
    end 
    second_client.client_email.each do |ac|
      ac.client_id = self.id
      ac.save 
    end
  end

  def usseles_client?
    self.accords_client.blank? && self.leasing_contract_clients.blank?
  end

  def self.remove_usseles_clients
    Client.includes(:accords_client).includes(:accords_client).where(id: Client.select(&:usseles_client?).map{|a| a.id}).delete_all
  end

  def self.duplicate_clients
    personal_identification_number_list = Client.where('personal_identification_number != ""').select([:personal_identification_number, Client.arel_table[:personal_identification_number].count]).having(Client.arel_table[:personal_identification_number].count.gt(1)).group(:personal_identification_number).pluck(:personal_identification_number)
    list = []
    personal_identification_number_list.each do |personal_identification_number|
      first_client = Client.where(personal_identification_number: personal_identification_number).first
      last_client = Client.where(personal_identification_number: personal_identification_number).last
      first_client.joins_clients(last_client)
      list << first_client.id
    end
    SchedulerLog.create(kind: 'Client', list: list) unless list.blank?
    Client::remove_usseles_clients
  end
end