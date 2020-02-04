require 'csv'
module FilteringColums::User

	def filtering_attributes_admin
		{
			"contract_volume_bussines" => 'Objem smluv - OBCHOD',
			"count_contract_bussines" => 'KS smluv - OBCHOD',
			"sum_contract_one_of_payment" => 'Jednorázově vyplaceno" - OBCHOD',
			"events_for_the_period" => 'Přiřazené události',
			"events_meeting_with_advisors" => 'Splněné schůzky s poradci',
			"count_accord_for_user_in_interval" => 'Navedeno žádostí',
			"count_accord_to_terrain" => 'Zasláno do terénu',
			"count_new_cooperation" => 'Nová spolupráce',
			"count_not_termination_cooperation" => 'Smlouvy bez výpovědí',
			"count_active_cooperation" => 'Aktivní poradci',
			"count_not_termination_incomplate_cooperation" => 'Nekompletní dokumentace',
			"contract_volume_servise" => 'Objem smluv - SERVIS',
			"count_contract_servise" => 'KS smluv - SERVIS',
			"sum_contract_one_of_payment_service" => 'Jednorázově vyplaceno  - SERVIS',
		}
	end

	def filtering_attributes_manager
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
			"complate_documentation"=>'Kompletní dokumentace',
			"web"=>'Web',
			"created_at"=>'Datum založení',
			"updated_at"=>'Datum poslední aktualizace',
			"count_accord"=>'Celkem žádostí',
			"date_of_last_create_accord"=>'Datum navedení poslední žádosti',
			"count_contract"=>'Celkem smluv',
			"date_of_last_contract"=>'Datum podepsání poslední smlouvy',
			"terrain_count" => 'Počet obdrženo do terénu',
			"last_terrain" => 'Datum obdržení do terénu',
			"accord_terrain_in_agent_count" => 'Počet žádostí agenta v terénu',
			"accord_terrain_in_agent" => 'Datum poslední žádosti agenta v terénu',
			"agent_accords_signature_count" => 'Počet u podpisu',
			"agent_accords_signature" => 'Datum posledního podpisu',
		}
	end

	def filtering_attributes_agent
		{

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