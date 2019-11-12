require 'csv'
namespace :import_teren do
  task :import => :environment do
  		file = File.open Rails.root.join('tmp', 'teren.csv')
  		convert = { 
		 	'id'=> 'accord_id', 
  			'resi_agent_id'=> 'agent_id',
  			'datum_foceni'=> 'date_to_terrain',
  			}
  		CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
  			number = h.delete('accord_id')
			a  = Accord.find_by_number(number)
			unless a.blank?
				l = Terrain.new(h)
				l.accord_id = a.id
				l.user_id = 1
				l.save(validate:false)
			end
		end
  	end
 end