require 'csv'
namespace :import_leasing do
  task :import => :environment do
  		file = File.open Rails.root.join('tmp', 'najemni.csv')
  		convert = { 
		 	'SMLOUVA'=> 'contract_number', 
  			'NÁJEM OD'=> 'rent_from',
        	'NÁJEM DO'=> 'rent_to',
        	'DEN SPLÁCENÍ'=> 'payment_day',
        	'VÝŠE NÁJMU'=> 'monthly_rent'
  			}
  		CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
  			number = h.delete('contract_number')
			a  = Accord.find_by_contract_number(number)
			unless a.blank?
				l = LeasingContract.new(h)
				l.accord_id = a.id
				l.save(validate:false)
			end
		end
  	end
 end