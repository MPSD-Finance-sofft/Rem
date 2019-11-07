require 'csv'
namespace :import_accord do
  task :import => :environment do
  	file = File.open Rails.root.join('tmp', 'zadost_insolvence.csv')
  	convert = {
  			'id' => 'number', 
  			'stav'=> 'state', 
  			'zpracoval'=> 'user_id', 
  			'provize_fp_procent_z_jistiny' => 'agency_commission', 
  			'resi_agent_id' => 'nil' , 
  			'cas_prijeti' => 'created_at', 
  			'agent_id' => 'agent_id'}
  	CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
			if Accord.where(number: (h['number'])).blank?
				r = Accord.new h
				r.kind = 'insolvency_buyout'
				r.save(validate:false)
			end
		end
  end
end