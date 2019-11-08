require 'csv'
namespace :constract do
  task :import => :environment do
  		file = File.open Rails.root.join('tmp', 'smlouvy.csv')
  		convert = {
  			'zadost_id' => 'number', 
			'cislo_smlouvy'=> 'contract_number', 
  			'datum_podpisu'=> 'date_of_signature'
  			}
  		CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
  			number = h.delete('number')
			a  = Accord.find_by_number(number)
			unless a.blank?
				c = h.delete('contract_number')
				d = h.delete('date_of_signature')
				a.contract_number =c
				a.date_of_signature = d
				a.save
			end
		end
  	end
 end