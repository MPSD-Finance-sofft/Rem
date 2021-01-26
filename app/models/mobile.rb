class Mobile < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
  has_many :client_mobiles,  :dependent => :destroy
  has_many :user_mobiles,  :dependent => :destroy
end
