class Address < ApplicationRecord
	has_many :user_address
  has_many :realties
  has_many :permanent_address_client, class_name: 'Client', foreign_key: 'permanent_address_id'
  has_many :contact_address_client, class_name: 'Client', foreign_key: 'contact_address_id'

	def full_name
		"#{self.street.to_s} #{self.number.to_s} #{self.ev_number.to_s}, #{self.zip.to_s} #{self.village.to_s}, okr. #{self.district.to_s}"
	end

	def index_name
    if street == village
      "#{self.street.to_s} #{self.number.to_s} #{self.ev_number.to_s}, #{self.zip.to_s}"
    else
		  "#{self.street.to_s} #{self.number.to_s} #{self.ev_number.to_s}, #{self.zip.to_s} #{self.village.to_s}"
    end
	end

	def number
		number = self.attributes["number"]
		if number.split("/").size != 2
			number.delete("/")
		else
			number
		end unless number.blank?
	end

	def zip
		zip = self.attributes["zip"]
		zip.insert(3, " ") if !zip.blank? && zip.size >= 3
	end

  def usseles?
    Address.reflections.values.map {|reflection| send(reflection.name)}.flatten.compact.blank?
  end

  def self.remove_usseles_adress
    Address.select(&:usseles?).map{|a| a.delete}
  end

  def self.duplication_address
    Address.all.group_by{|a| a.full_name}.select{|k,v| v.size > 1}
  end

  def self.synthesis_address
    duplicate_address_list = Address::duplication_address
    list = []
    duplicate_address_list.each do |k,v|
      first = v.first
      last = v.last

      Client.where(permanent_address_id: last.id).update_all(permanent_address_id: first.id)
      Client.where(contact_address_id: last.id).update_all(contact_address_id: first.id)
      Realty.where(address_id: last.id).update_all(address_id: first.id)
      UserAddress.where(address_id: last.id).update_all(address_id: first.id)
      list << first.id
    end
    SchedulerLog.create(kind: 'Duplicate Address', list: list) unless list.blank?
    Address::remove_usseles_adress
  end
end