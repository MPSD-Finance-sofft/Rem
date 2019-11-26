class User < ApplicationRecord
	attr_accessor :current_user
	validates_with UserValidator
	has_paper_trail ignore: [:updated_at, :id, :encrypted_password]
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :recoverable, :rememberable, :masqueradable, authentication_keys: [:username]
	#has_attached_file :avatar
	has_one_attached :avatar
  #	do_not_validate_attachment_file_type :avatar
	has_many :messages, :dependent => :destroy
	has_many :conversations, foreign_key: :sender_id, :dependent => :destroy
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
	has_many :notifications, class_name: "Notification", foreign_key: "user_id"

	accepts_nested_attributes_for :permission,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_mobile,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_address,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_email,  reject_if: :all_blank, allow_destroy: true
	validates_confirmation_of :password

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

	def encrypted_password=(value)
		return if value.blank?
		super
	end

	def self.user_can_permision(user)
		if user.agent? || user.manager?
			User.can_sign_in.subordinates(user).or(User.where(id: (user.id)))
		else
			User.can_sign_in.select(&:not_runing_notice?)
		end
	end
		 
	scope :subordinates, -> (user) {where(superior_id: user.id)}
	scope :subordinates_id, -> (user_id) {where(superior_id: user_id)}
	scope :permission_fo_user, -> (permission) {joins(:permission).where('permissions.kind': permission)}
	scope :agents,   ->{ joins(:permission).where('permissions.kind': 'agent') }
	scope :manager_and_user,   ->{ joins(:permission).where('permissions.kind': ['manager','user']) }
	scope :manager_and_agents,   ->{ joins(:permission).where('permissions.kind': ['manager','agent']) }
	scope :manager,   ->{ joins(:permission).where('permissions.kind': 'manager') }
	scope :can_sign_in, -> {where(can_sign_in: true)}
	scope :all_without_user,   ->{ joins(:permission).where('permissions.kind': ['manager','user','agent']) }
end
