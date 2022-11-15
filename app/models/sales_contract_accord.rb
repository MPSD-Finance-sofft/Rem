class SalesContractAccord < ApplicationRecord
  has_paper_trail ignore: [:updated_at]
  belongs_to :accord
  belongs_to :sales_contract

end
