class ::UserValidator < ActiveModel::Validator

	def validate(record)
		agent_validate(record)
	end

	def agent_validate(record)
		if record.agent?
			agent_company(record)
			agent_date_of_cooperation(record)
			agent_bank_code(record)
			agent_account_number(record)
			agent_name_company(record)
		end
		admin_permmision_valid(record)
	end

	def agent_company(record)
		record.errors.add(:identity_company_number, 'Společnost u agenta musí být vyplněna!!!') if record.identity_company_number.blank?
	end

	def agent_date_of_cooperation(record)
		record.errors.add(:date_of_cooperation, 'Datum spoluráce musí být vyplněno!!!') if record.date_of_cooperation.blank?
	end

	def agent_bank_code(record)
		record.errors.add(:bank_code, 'Bankovní kod musí být vyplněn!!!') if record.bank_code.blank?
	end

	def agent_account_number(record)
		record.errors.add(:account_number, 'Číslo učtu musí být vyplněno!!!') if record.account_number.blank?
	end

	def agent_name_company(record)
		record.errors.add(:name_company, 'Společnost u agenta musí být vyplněna!!!') if record.name_company.blank?
	end

	def admin_permmision_valid(record)
		record.errors.add(:kind, 'Admina muže upravovat jen admin!!!') if record.admin? && record.current_user.not_admin?
	end

end