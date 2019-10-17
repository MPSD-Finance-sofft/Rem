module PenbEnum extend ActiveSupport::Concern
	
	included do 
		enum energy_class: [:a, :b, :c, :d, :e, :f, :g]
	end
end