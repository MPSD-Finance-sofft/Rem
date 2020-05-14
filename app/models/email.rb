class Email < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
  has_many :client_emails,  :dependent => :destroy
end
