module RealtieEnum extend ActiveSupport::Concern
	
	included do 
		enum type_ownership: [:part,:exclusiv, :sjm]
		enum record_on_lv: [:burden, :execution, :hypothec,:insolvency_manager ,:unknown, :pledge]
		enum location: [:county_seat, :discrit_town, :country_seat_15_km, :district_town_15_km]
	end
end