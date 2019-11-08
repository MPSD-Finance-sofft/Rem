namespace :accord_purchase_price do
  task :purchase_price_from_realty => :environment do
  		Accord.all.each do |accord|
  			r = accord.realty.first
  			a = accord
  			unless r.blank?
  				a.purchase_price = r.purchase_price.to_s
  				a.save
  			end
  		end
  end
end