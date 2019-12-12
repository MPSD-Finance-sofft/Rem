namespace :nevim do
  task :nevim => :environment do
  	file = File.open Rails.root.join('tmp', 'um_u_podpisu.csv')
  	convert = {"zadost_id"=> "accord_id", "om_u_podpisu_id" => 'agent_in_signature_id'}
  	CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  		h = row.to_hash
  		a = h.delete('accord_id') 
  		a = Accord.find_by_number a
  		unless a.blank?
  			a.agent_in_signature_id	= h.delete('agent_in_signature_id')
  			a.save
  		end
	end
  end
end