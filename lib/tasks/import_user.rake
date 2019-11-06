require 'csv'
namespace :import_user do
  task :import => :environment do
  	file = File.open Rails.root.join('tmp', 'agenti.csv')
  	convert = {"Login"=> "login", "Přihlašovací jméno" => 'username', 'Heslo' => 'password', 'Role' => 'kind', 'Nadřízený ID' => 'superior_id',
  		'Pozice' => 'short_name', 'Jméno' => 'name', 'Příjmení' => 'last_name', 'Titul před' => 'title_before', 'Titul za'=> 'title_last',
  		'Datum narození' => 'birthdate', 'Jméno společnosti' => 'name_company', 'IČ' => 'identity_company_number', 'Datum navázání spolupráce'=> 'date_of_cooperation',
  		'Web'=> 'web', 'Číslo účtu' => 'account_number', 'Kód banky'=> 'bank_code', 'Může se přihlásit'=> 'can_sign_in', 'Kompletní dokumentace'=> 'complate_documentation', 'Agent ID'=> 'id', 'Mobil'=> 'mobil' , 'Mobil II'=> 'mobil2' , 'Email'=> 'email', 'Ulice fakturační' => 'address_bil_street', 'Č. p./č. o.r. fakturační' => 'address_bil_cp', 'PSČ fakturační' => 'address_bil_psc', 'Obec fakturační'=> 'address_bil_village', 'Okres fakturační'=> 'address_bil_district', 'Kraj fakturační'=> 'address_bil_region',
  		'Ulice bydliště' => 'address_permanent_street', 'Č. p./č. o.r. bydliště' => 'address_permanent_cp', 'PSČ bydliště' => 'address_permanent_psc', 'Obec bydliště'=> 'address_permanent_village', 'Okres bydliště'=> 'address_permanent_district', 'Kraj bydliště'=> 'address_permanent_region',
  	'Ulice korespond.' => 'address_mailing_street', 'Č. p./č. o.r. korespond.' => 'address_mailing_cp', 'PSČ korespond.' => 'address_mailing_psc', 'Obec korespond.'=> 'address_mailing_village', 'Okres korespond.'=> 'address_mailing_district', 'Kraj korespond.'=> 'address_mailing_region', "Typ ukončení"=> 'typ_ukonceni', "Datum ukončení spolupráce"=> 'date', "Nadřízený"=> 'superior'}
  	CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			kind = row.delete('kind').last
  			mobil = row.delete('mobil').last
  			mobil2 = row.delete('mobil2').last
  			email = row.delete('email').last
  			login = row.delete('login')
  			typ_ukonceni= row.delete('typ_ukonceni')
  			date= row.delete('date')
  			superior= row.delete('superior')
  			address_bil = Address.new
  			address_bil.street = row.delete('address_bil_street').last
  			address_bil.village = row.delete('address_bil_village').last
  			address_bil.number = row.delete('address_bil_cp').last
  			address_bil.zip = row.delete('address_bil_psc').last
  			address_bil.district = row.delete('address_bil_district').last
  			address_bil.region = row.delete('address_bil_region').last
  			address_permanent = Address.new
  			address_permanent.street = row.delete('address_permanent_street').last
  			address_permanent.village = row.delete('address_permanent_village').last
  			address_permanent.number = row.delete('address_permanent_cp').last
  			address_permanent.zip = row.delete('address_permanent_psc').last
  			address_permanent.district = row.delete('address_permanent_district').last
  			address_permanent.region = row.delete('address_permanent_region').last
  			address_mailing = Address.new
  			address_mailing.street = row.delete('address_mailing_street').last
  			address_mailing.village = row.delete('address_mailing_village').last
  			address_mailing.number = row.delete('address_mailing_cp').last
  			address_mailing.zip = row.delete('address_mailing_psc').last
  			address_mailing.district = row.delete('address_mailing_district').last
  			address_mailing.region = row.delete('address_mailing_region').last
  			h = row.to_hash
  			h.delete(nil)
			r = User.new h
			r.save(validate:false)
			a = r.address.build(address_bil.attributes)
			b = r.address.build(address_permanent.attributes)
			c = r.address.build(address_mailing.attributes)
			a.user_address.kind = 'billing'
			b.user_address.kind = 'permanent'
			c.user_address.kind = 'mailing'
			r.mobile.build(phone_number: mobil) unless mobil.blank?
			r.mobile.build(phone_number: mobil2) unless mobil2.blank?
			r.email.build(email_address: email) unless email.blank?
			r.build_permission(kind: kind) unless kind.blank?
			r.save(validate:false)
		end
  end
end