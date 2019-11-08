require 'csv'
namespace :import_clients do
  task :import => :environment do
  	file = File.open Rails.root.join('tmp', 'klienti.csv')
  	convert = {
  			'zadost_id' => 'accord_id', 
  			'vztah'=> 'relationship',
  			'telefon'=> 'mobile',
  			'email'=> 'email',
  			'jmeno'=> 'name',
  			'prijmeni'=> 'last_name',
  			'cislo_op'=> 'identity_card_number',
  			'rodne_cislo'=> 'personal_identification_number',
  			'rodinny_stav'=> 'relation_ship',
  			}
  	CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)	
  			accord_id = h.delete('accord_id')
  			a = Accord.find_by_number(accord_id)
  			ac = AccordsClient.new(relationship: h.delete('relationship'), accord_id: a.id)
  			mobile = h.delete('mobile')
  			email = h.delete('email')
  			c = Client.new(h)
  			m = Mobile.new(phone_number:mobile)
  			e = Email.new(email_address:email)
  			c.mobile = [m] unless m.phone_number == '0'
  			c.email = [e] unless e.email_address == '@'
  			c.personal_identification_number = '' if c.personal_identification_number.first == '-'
  			c.save
  			ac.client_id = c.id
  			ac.save
		end
  	end
end