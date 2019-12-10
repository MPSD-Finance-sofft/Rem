module FilteringColums::User
	
	def filtering_attributes
		{
			"id" => "id",
			"all_name" => 'Celé jméno',
			 "created_at" => 'Datum vytvoření',
			 "updated_at" => 'Datum poslední aktualizace',
			 "username" => 'Login',
			 "name_company" => 'Název společnosti',
			 "identity_card_number" => 'identity_card_number',
			 "identity_company_number" => 'identity_card_number',
			 "date_of_cooperation" => 'Datum navázání spolupráce',
			 "short_name" => 'Pozice',
			 "superior" => 'Nadřízený',
			 "web" => 'Web',
			 "full_bank_code" => 'Číslo učtu',
			 "can_sign_in" => 'Muže se přihlásit',
			 "complate_documentation" => 'Kompletní dokumentace',
			 "birthdate" => 'Datum narození',
			 "permission_to_s" => 'Oprávnění'
		}
	end
end