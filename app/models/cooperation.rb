class Cooperation < ApplicationRecord
	belongs_to :or_request, class_name: "User", :dependent => :destroy
	belongs_to :type_of_notice
end
