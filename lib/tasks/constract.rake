require 'csv'
namespace :constract do
  task :import => :environment do
  		file = File.open Rails.root.join('tmp', 'data_nemovitosti.csv')
  		convert = { 
			 'cislo_smlouvy'=> 'contract_number', 
  			'datum_prepisu_vlastnictvi_nemovitosti'=> 'date_of_ownership',
        'datum_predani_nem_firme'=> 'date_of_transfer'
  			}
  		CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
  			number = h.delete('contract_number')
			a  = Accord.find_by_contract_number(number)
			unless a.blank?
				c = h.delete('date_of_ownership')
				d = h.delete('date_of_transfer')
				a.date_of_ownership =c
				a.date_of_transfer = d
				a.save
			end
		end
  	end
 end