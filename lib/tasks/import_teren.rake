require 'csv'
namespace :import_teren do
  task :import => :environment do
  		file = File.open Rails.root.join('tmp', 'penb.csv')
  		convert = { 
		 	  'zadost_id'=> 'accord_id', 
  			'datum_vytvoreni'=> 'created_at',
  			'datum_odeslani'=> 'date_send',
        'castka'=> 'price',
        'datum_prijeti_fin'=> 'date_send_tax_office',
        'datum_platby_dane'=> 'tax_pay_date',
        'cislo_vkladu'=> 'number',
  			}
  		CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
  			number = h.delete('accord_id')
			a  = Accord.find_by_number(number)
			unless a.blank?
				l = TaxReturn.new(h)
				l.accord_id = a.id
				l.save(validate:false)
			end
		end
  	end
 end