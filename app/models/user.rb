class User < ApplicationRecord
	extend FilteringColums::User
	include Reports::User
	include Versions::Base
	include ConnectionAres::User
	attr_accessor :current_user
	validates_with UserValidator
	has_paper_trail ignore: [:updated_at, :id, :encrypted_password]
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :recoverable, :rememberable, :masqueradable, authentication_keys: [:username]
	#has_attached_file :avatar
	has_one_attached :avatar
  #	do_not_validate_attachment_file_type :avatar
	has_many :cooperations, foreign_key: :agent_id
	has_many :user_mobile
	has_many :user_email
	has_many :mobile, through: :user_mobile
	has_many :email, through: :user_email
	has_many :user_address
	has_many :address, through: :user_address
	has_one :permission, :dependent => :destroy
	belongs_to :superior, class_name: "User", foreign_key: "superior_id"
	has_one :subordinate, class_name: "User", foreign_key: "superior_id"
	has_many :agent_accords, class_name: "Accord", foreign_key: "agent_id"
	has_one :agent_accords_last, -> { order created_at: :desc }, class_name: "Accord", foreign_key: "agent_id"
	has_many :agent_accords_signature, class_name: "Accord", foreign_key: "agent_in_signature_id"
	has_many :notifications, class_name: "Notification", foreign_key: "user_id"
	has_many :alerts, class_name: "Alert", foreign_key: "user_id"
	has_many :terrains, class_name: "Terrain", foreign_key: "agent_id"
	has_many :user_documents
	has_many :ares, class_name: "Ares", foreign_key: "user_id"

	accepts_nested_attributes_for :permission,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_mobile,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_address,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_email,  reject_if: :all_blank, allow_destroy: true
	validates_confirmation_of :password

	after_save :remove_with_zero_adress

	def remove_with_zero_adress
		self.user_address.each do |ua|
			ua.destroy if ua.address_id.nil?
		end
	end

	def all_name
	 self.title_before.to_s + ' ' + self.last_name.to_s + ' ' +  self.name.to_s + ' ' + self.title_last.to_s + ' (' + self.username.to_s + ')'
	end

	def admin?
		self.permission.try(:kind) == "admin"
	end

	def not_admin?
		self.permission.try(:kind) != "admin"
	end

	def user?
		self.permission.try(:kind) == "user" 
	end

	def agent?
		self.permission.try(:kind) == "agent" 
	end

	def manager?
		self.permission.try(:kind) == "manager" 
	end

	def can_login?
		self.can_sign_in
	end

	def runing_notice
		self.cooperations.last.try(:runing_notice?)
	end

	def not_runing_notice?
		!(runing_notice)
	end

	def not_runing_notice_ignor_exist?(agent_id)
		!(runing_notice) || (agent_id == self.id)
	end

	def without_contract?
		self.cooperations.last.try(:lost_cooperation?)
	end

	def user_or_admin?
		self.permission.try(:kind) == "user" || self.permission.try(:kind) == "admin"
	end

	def user_or_manager?
		self.permission.try(:kind) == "user" || self.permission.try(:kind) == "manager"
	end

	def self.can_create_accord(user)
		if user.agent? || user.manager?
			User.can_sign_in.subordinates(user).or(User.can_sign_in.where(id: (user.id)))
		else
			User.manager_and_agents.can_sign_in.select(&:not_runing_notice?)
		end
	end

	def self.can_create_accord_with_exist(agent_id)
		User.manager_and_agents.can_sign_in.or(User.manager_and_agents.where(id: agent_id)).select{|a| a.not_runing_notice_ignor_exist?(agent_id)}
	end

	def self.user_can_sign_id
		User.manager_and_user.can_sign_in
	end

	def count_accord
		self.agent_accords.count
	end

	def count_contract
		self.agent_accords.state('contract').count
	end

	def date_of_last_create_accord
		self.agent_accords.last.try(:created_at)
	end

	def date_of_last_create_accord_smaller_then_60?
		return false if date_of_last_create_accord.nil?
		Time.now - date_of_last_create_accord <= 60.day
	end

	def date_of_last_contract
		self.agent_accords.state('contract').last.try(:date_of_signature)
	end

	def encrypted_password=(value)
		return if value.blank?
		super
	end

	def self.user_can_permision(user)
		if user.agent? || user.manager?
		  User.can_sign_in.subordinates(user).or(User.where(id: (user.id)))
		else
			User.order(username: :desc).select(&:not_runing_notice?)
		end
	end

	def self.all_subordinates(user)
		User.my_subordinates(user).each do |subordinate|
			next if User.my_subordinates(subordinate).blank? || subordinate == user
			return User.my_subordinates(user) + User::all_subordinates(subordinate)
		end
	end

	def self.subordinates(user)
		User.where(id: all_subordinates(user))
	end

	def self.downalod_data_from_ares
		list = []
    Ares.delete_all
		User.all.each do |user|
			list << user.id if user.downalod_data_from_ares
		end
		#SchedulerLog.create(kind: 'UserDownloadDataFromAres', list: list) unless list.blank?
	end

	def self.company_name_from_ares
		list = []
		 User.all.each do |user|
			list << user.id if user.change_name_company
		end
		SchedulerLog.create(kind: 'UserChangeCompynNameFromAres', list: list) unless list.blank?
	end

	scope :my_subordinates, -> (user) {where(superior_id: user.id)}
	scope :username, -> (user) {where("users.username LIKE ? ", "%#{user}%")}
	scope :id, -> (user) {where(id: user.id)}
	scope :id_user, -> (user) {where(id: user)}
	scope :company, -> (company) {where(name_company: company)}
	scope :subordinates_id, -> (user_id) {where(superior_id: user_id)}
	scope :permission_fo_user, -> (permission) {joins(:permission).where('permissions.kind': permission)}
	scope :agents,   ->{ joins(:permission).where('permissions.kind': 'agent') }
	scope :permission_user,   ->{ joins(:permission).where('permissions.kind': 'user') }
	scope :manager_and_user,   ->{ joins(:permission).where('permissions.kind': ['manager','user']) }
	scope :admin_and_user,   ->{ joins(:permission).where('permissions.kind': ['admin','user']) }
	scope :manager_and_agents,   ->{ joins(:permission).where('permissions.kind': ['manager','agent']) }
	scope :manager,   ->{ joins(:permission).where('permissions.kind': 'manager') }
	scope :can_sign_in, -> {where(can_sign_in: true)}
	scope :all_without_user,   ->{ joins(:permission).where('permissions.kind': ['manager','user','agent']) }
  scope :user_ares,   -> (nace) { joins(:ares).where('ares.nace': nace).distinct }
end
