module FilteringColums::User
	
	def filtering_attributes
		[
			"id",
			 "created_at",
			 "updated_at",
			 "username",
			 "name",
			 "last_name",
			 "name_company",
			 "identity_card_number",
			 "identity_company_number",
			 "date_of_cooperation",
			 "short_name",
			 "superior_id",
			 "title_before",
			 "title_last",
			 "web",
			 "account_number",
			 "bank_code",
			 "active",
			 "can_sign_in",
			 "complate_documentation",
			 "birthdate"
		]
	end
end