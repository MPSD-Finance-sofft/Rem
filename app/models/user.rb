class User < ApplicationRecord
	has_paper_trail ignore: [:updated_at, :id, :encrypted_password]
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,  authentication_keys: [:username]
	has_attached_file :avatar
  	do_not_validate_attachment_file_type :avatar
	has_many :messages, :dependent => :destroy
	has_many :conversations, foreign_key: :sender_id, :dependent => :destroy
	has_one :permission, :dependent => :destroy
	has_one :superior, class_name: "User", foreign_key: "superior_id"

	accepts_nested_attributes_for :permission,  reject_if: :all_blank, allow_destroy: true

	def all_name
		self.name.to_s + ' ' + self.last_name.to_s
	end
end
