class Expense < ApplicationRecord
	include RemoveWhiteSpiceFromNumberInput::Commitment
	belongs_to :expense_type
  belongs_to :accord
	belongs_to  :realty, required: false

	has_paper_trail ignore: [:updated_at]

	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
  scope :expense_type_id, -> (expense_type_id) {where(expense_type_id: expense_type_id)}

	validates :accord_id, presence: true
	validates :expense_type_id, presence: true
	validates :amount, presence: true

	validates_each :realty_id do |record, attr, value|
    if record.accord.realty.size > 1
      record.errors.add(attr, "Pokud má smlouva více nemovitostí, tak nemovitost musí být přiřazena.") if value.blank?
    end
  end
end
