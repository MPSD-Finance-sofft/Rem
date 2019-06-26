class User < ApplicationRecord
	attr_accessor :current_user
	validates_with UserValidator
	has_paper_trail ignore: [:updated_at, :id, :encrypted_password]
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :recoverable, :rememberable, :validatable, :masqueradable, authentication_keys: [:username]
	has_attached_file :avatar
  	do_not_validate_attachment_file_type :avatar
	has_many :messages, :dependent => :destroy
	has_many :conversations, foreign_key: :sender_id, :dependent => :destroy
	has_many :cooperations, foreign_key: :agent_id , :dependent => :destroy
	has_many :user_mobile
	has_many :mobile, through: :user_mobile
	has_many :user_address
	has_many :address, through: :user_address
	has_one :permission, :dependent => :destroy
	belongs_to :superior, class_name: "User", foreign_key: "superior_id"
	has_one :subordinate, class_name: "User", foreign_key: "superior_id"

	accepts_nested_attributes_for :permission,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_mobile,  reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :user_address,  reject_if: :all_blank, allow_destroy: true


	def all_name
	 self.title_before.to_s + ' ' + self.last_name.to_s + ' ' +  self.name.to_s + ' ' + self.title_last.to_s + ' (' + self.username + ')'
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

	def without_contract?
		self.cooperations.last.try(:lost_cooperation?)
	end
	 
	scope :subordinates, -> (user) {where(superior_id: user.id)}
	scope :agents,   ->{ joins(:permission).where('permissions.kind': 'agent') }
end
