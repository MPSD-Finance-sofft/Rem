require 'csv'
namespace :import_commitments do
  task :import => :environment do
  		file = File.open Rails.root.join('tmp', 'naklady.csv')
  		convert = { 
	 	  	'zadost_id'=> 'accord_id', 
  			'typ_nakladu_id'=> 'expense_type_id',
  			'castka'=> 'amount',
        	'skutecne_vyplacena_castka'=> 'real_amount',
        	'datum_predpokladaneho_terminu_vyplaceni'=> 'date_of_excepted_payment',
        	'datum_vyplaceni'=> 'payout_day',
        	'popis'=> 'description',
  			}
  		CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
  			number = h.delete('accord_id')
			a  = Accord.find_by_number(number)
			unless a.blank?
				l = Expense.new(h)
				l.accord_id = a.id
				l.save(validate:false)
			end
		end
  	end
 end