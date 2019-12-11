require 'csv'
module FilteringColums::User
	
	def filtering_attributes
		{
			"all_name" => 'Celé jméno',
			"name_company" => 'Jméno společnost',
			"identity_company_number" => 'IČ',
			"id" => 'ID',
			"username" => 'Přihlašovací jméno',
			"superior" => 'Nadřízený',
			"mobile_to_s"=>'Telefon',
			"email_to_s"=>'E-mail',
			"full_bank_code"=>'Bankovní spojení',
			"birthdate"=>'Datum narození',
			"billing_address_to_s"=>'Fakturační adresa',
			"billing_address_district_to_s"=>'Okres fakturační',
			"mailing_address_to_s"=>'Korespondenční adresa',
			"mailing_address_district_to_s"=>'Okres korespondenční',
			"permanent_address_to_s"=>'Adresa trvalého bydliště',
			"permanent_address_district_to_s"=>'Okres bydliště',
			"permission_to_s"=>'Role',
			"short_name"=>'Pozice',
			"date_of_cooperation"=>'Datum navázání spolupráce',
			"can_sign_in"=>'Muže se přihlásit',
			"can_sign_in"=>'Běží výpověď',
			"complate_documentation"=>'Kompletní dokumentace',
			"web"=>'Web',
			"created_at"=>'Datum založení',
			"updated_at"=>'Datum poslední aktualizace',
			"count_accord"=>'Celkem žádostí',
			"date_of_last_create_accord"=>'Datum navedení poslední žádosti',
			"count_contract"=>'Celkem smluv',
			"date_of_last_contract"=>'Datum podepsání poslední smlouvy',
			"terrain_count" => 'Počet terénu',
			"last_terrain" => 'Datum kdy byl naposledy v terénu',
		}
	end

	def to_csv(attributes)
    	CSV.generate(headers: true) do |csv|
	      	csv << attributes.map{|a| User::filtering_attributes[a]}
	      	all.decorate.each do |user|
	        	csv << attributes.map{ |attr| user.send(attr) }
	      	end
    	end
  	end
end