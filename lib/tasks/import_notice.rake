require 'csv'
namespace :import_notice do
  task :import => :environment do
  	file = File.open Rails.root.join('tmp', 'poznamky.csv')
  	convert = {
  			'zadost_id' => 'number', 
  			'username'=> 'username_id', 
  			'cas'=> 'created_at', 
  			'typ' => 'typ', 
  			'obsah' => 'description' , 
  			}
  	CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
			h = row.to_hash
			number = h.delete('number')
			accord = Accord.find_by_number number
			unless accord.blank?
				n = Note.new
				n.accord_id = accord.id
				n.user_id = h.delete('username_id')
				n.description = h.delete('description')
				n.created_at = h.delete('created_at')
				typ = h.delete('typ')
				if typ == 'veřejná'
					typ = "agent"
				elsif typ == 'verejna'
					typ = "agent"
				elsif typ == 'od_om'
					typ = 'manager'
				elsif typ == 'pro_om'
					typ = 'manager'
				elsif typ == 'závěr_risk'
					typ = 'manager'
				elsif typ == 'závěr_fp_risk'
					typ = 'manager'
				elsif typ == 'interní'
					typ = 'manager'
				else
					typ = 'user'
				end
				n.permission = typ
				n.save(validate:false)
			end
  		end
  	end
end